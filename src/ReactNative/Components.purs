module ReactNative.Components where

import Prelude (class Eq, Unit, ($), (<>), bind, pure, unit)
import Data.Array (snoc)
import Data.Function (mkFn2)
import Control.Monad.Eff (Eff)
import React (ReactElement, ReadWrite, ReactState, ReadOnly, ReactRefs, ReactProps, ReactClass, ReactSpec, ReactThis, getProps)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Props (ListViewDataSource)

foreign import createNativeElement :: forall props. ReactClass props -> props -> Array ReactElement -> ReactElement
foreign import createNativeClass :: forall props state eff. ReactSpec props state eff -> ReactClass props
foreign import viewClass :: forall props. ReactClass props
foreign import imageClass :: forall props. ReactClass props
foreign import textElem :: String -> ReactElement
foreign import textClass :: forall props. ReactClass props
foreign import listViewClass :: forall props. ReactClass props
foreign import touchableHighlightClass :: forall props. ReactClass props
foreign import touchableOpacityClass :: forall props. ReactClass props
foreign import touchableWithoutFeedbackClass :: forall props. ReactClass props
foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource
foreign import cloneWithRows :: forall a. ListViewDataSource -> Array a -> ListViewDataSource
foreign import textInputClass :: forall props. ReactClass props
foreign import navigatorClass :: forall props. ReactClass props

view :: Array Props -> Array ReactElement -> ReactElement
view = createNativeElement viewClass

image :: Array Props -> Array ReactElement -> ReactElement
image = createNativeElement imageClass

text :: Array Props -> String -> ReactElement
text props str = createNativeElement textClass props [textElem str]

text' :: Array Props -> Array ReactElement -> ReactElement
text' props = createNativeElement textClass props

textView :: Array Props -> Array ReactElement -> ReactElement
textView = createNativeElement textClass

listView :: Array Props -> ReactElement
listView props = createNativeElement listViewClass props []

touchableHighlight :: Array Props -> ReactElement -> ReactElement
touchableHighlight props element = createNativeElement touchableHighlightClass props [element]

touchableOpacity :: Array Props -> ReactElement -> ReactElement
touchableOpacity props element = createNativeElement touchableOpacityClass props [element]

touchableWithoutFeedback :: Array Props -> ReactElement -> ReactElement
touchableWithoutFeedback props element = createNativeElement touchableWithoutFeedbackClass props [element]

textInput :: Array Props -> ReactElement
textInput props = createNativeElement textInputClass props []

foreign import passPropsToProps :: forall props. props -> props

data ComponentProps customProps props = ComponentProps
    { customProps :: customProps
    , initialProps :: Array Props
    , props :: forall eff. Eff (props :: ReactProps | eff) props
    }

getCustomProps :: forall customProps props state eff. ReactThis (ComponentProps customProps props) state -> Eff (props :: ReactProps | eff) customProps
getCustomProps ctx = do
    ComponentProps compProps <- getProps ctx
    pure compProps.customProps

getReactProps :: forall customProps props state eff. ReactThis (ComponentProps customProps props) state -> Eff (props :: ReactProps | eff) props
getReactProps ctx = do
    ComponentProps compProps <- getProps ctx
    compProps.props

componentProps :: forall customProps props. customProps -> Array Props -> ComponentProps customProps props
componentProps customProps props = ComponentProps
    { customProps: customProps
    , initialProps: props
    , props: uninitializedProps
    }

foreign import unsafeThrowPropsNotInitializedException :: forall eff props. Eff (props :: ReactProps | eff) props

uninitializedProps :: forall eff props. Eff (props :: ReactProps | eff) props
uninitializedProps = unsafeThrowPropsNotInitializedException

type NavigatorChildProps a =
    { navigator :: ReactElement
    | a
    }

foreign import data Navigate :: !

type NavigatorRouteType customProps props =
    { title :: String
    , component :: ReactClass (ComponentProps customProps (NavigatorChildProps props))
    , passProps :: ComponentProps customProps (NavigatorChildProps props)
    }

data NavigatorRoute customProps props = NavigatorRoute (NavigatorRouteType customProps props)

newtype Navigator eff = Navigator
    { push :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
    , replace :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
    }

foreign import pushRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit
foreign import popRoute :: forall eff. ReactElement -> Eff (navigate :: Navigate | eff) Unit
foreign import replaceRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit

foreign import getNavigationHelper :: forall props state eff eff1. ReactThis props state -> Eff (props :: ReactProps | eff) (Navigator eff1)

type NavigationHandler eff result = (ReactElement -> NavigationEvent -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) result)

navigationHelper :: forall eff result. NavigationHandler eff result -> Props
navigationHelper handler = unsafeMkProps "navigationHelper" navi
    where
        navi = (Navigator
                    { push: push
                    , replace: replace
                    })
        push :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
        push element (NavigatorRoute r) = do
            pushRoute element $ adjustRoute r
            handler element Push
            pure unit
        replace :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
        replace element (NavigatorRoute r) = do
            replaceRoute element $ adjustRoute r
            handler element Push
            pure unit
        adjustRoute :: forall customProps props. NavigatorRouteType customProps props -> NavigatorRouteType customProps props
        adjustRoute r = r { passProps = passPropsToProps $ adjustPassProps r.passProps }
            where
                adjustPassProps (ComponentProps compProps) = ComponentProps (compProps {initialProps = snoc compProps.initialProps $ navigationHelper handler})

data NavigationEvent = Push

foreign import setNavigator :: forall customProps props. (ComponentProps customProps (NavigatorChildProps props)) -> ReactElement -> (ComponentProps customProps (NavigatorChildProps props))

navigator :: forall customProps props. NavigatorRoute customProps props -> (NavigatorRoute customProps props -> ReactElement -> ReactElement) -> Array Props -> ReactElement
navigator route render props =
    createNativeElement navigatorClass combinedProps []
    where
        combinedProps = props <> [initialRoute route, renderScene]
        initialRoute (NavigatorRoute r) = unsafeMkProps "initialRoute" r
        renderScene = unsafeMkProps "renderScene" callback
        callback = mkFn2 $ \r n -> do
            let nr = (NavigatorRoute (r {passProps = setNavigator r.passProps n}))
            render nr n
