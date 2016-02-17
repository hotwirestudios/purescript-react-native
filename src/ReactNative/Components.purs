module ReactNative.Components where

import Prelude (class Eq, Unit)
import Control.Monad.Eff (Eff)
import React (ReactClass, ReactElement, ReactRefs, ReactProps, ReadOnly, ReactSpec)
import React.DOM.Props (Props)
import ReactNative.Props (ListViewDataSource)

foreign import createNativeElement :: forall props. ReactClass props -> props -> Array ReactElement -> ReactElement
foreign import createNativeClass :: forall props state eff. ReactSpec props state eff -> ReactClass props
foreign import viewClass :: forall props. ReactClass props
foreign import textElem :: String -> ReactElement
foreign import textClass :: forall props. ReactClass props
foreign import listViewClass :: forall props. ReactClass props
foreign import touchableHighlightClass :: forall props. ReactClass props
foreign import touchableOpacityClass :: forall props. ReactClass props
foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource
foreign import cloneWithRows :: forall a. ListViewDataSource -> Array a -> ListViewDataSource
foreign import textInputClass :: forall props. ReactClass props

view :: Array Props -> Array ReactElement -> ReactElement
view = createNativeElement viewClass

text :: Array Props -> String -> ReactElement
text props str = createNativeElement textClass props [textElem str]

textView :: Array Props -> Array ReactElement -> ReactElement
textView = createNativeElement textClass

listView :: Array Props -> ReactElement
listView props = createNativeElement listViewClass props []

touchableHighlight :: Array Props -> ReactElement -> ReactElement
touchableHighlight props element = createNativeElement touchableHighlightClass props [element]

touchableOpacity :: Array Props -> ReactElement -> ReactElement
touchableOpacity props element = createNativeElement touchableOpacityClass props [element]

textInput :: Array Props -> ReactElement
textInput props = createNativeElement textInputClass props []

data ComponentProps customProps props = ComponentProps
    { customProps :: customProps
    , initialProps :: Array Props
    , props :: forall eff. Eff (refs :: ReactRefs ReadOnly, props :: ReactProps | eff) props
    }

componentProps :: forall customProps props. customProps -> Array Props -> ComponentProps customProps props
componentProps customProps props = ComponentProps
    { customProps: customProps
    , initialProps: props
    , props: uninitializedProps
    }

foreign import unsafeThrowPropsNotInitializedException :: forall eff props. Eff (refs :: ReactRefs ReadOnly, props :: ReactProps | eff) props

uninitializedProps :: forall eff props. Eff (refs :: ReactRefs ReadOnly, props :: ReactProps | eff) props
uninitializedProps = unsafeThrowPropsNotInitializedException

type NavigatorChildProps a =
    { navigator :: ReactElement
    | a
    }

foreign import data Navigate :: !

data NavigatorRoute props = NavigatorRoute
    { title :: String
    , component :: ReactClass props
    , passProps :: props
    }

newtype Navigator props = Navigator
    { push :: forall eff. NavigatorRoute props -> Eff (navigate :: Navigate | eff) Unit
    }

foreign import pushRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit

navigationHelper :: forall a props. NavigatorChildProps a -> Navigator props
navigationHelper props = Navigator
    { push: push
    }
    where
        push :: forall eff. NavigatorRoute props -> Eff (navigate :: Navigate | eff) Unit
        push (NavigatorRoute r) = pushRoute props.navigator r
