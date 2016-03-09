module ReactNative.Components where

import Prelude (Unit, unit, (==), ($), (<>), pure, bind)
import Data.Array (last, snoc)
import Data.Function (mkFn2)
import Data.Maybe (Maybe(Nothing, Just))
import Control.Monad.Eff (Eff)
import React (ReactElement, ReadWrite, ReactState, ReadOnly, ReactRefs, ReactProps, ReactClass, ReactSpec, ReactThis, getProps)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Styles (StyleProp, StyleId)

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
foreign import textInputClass :: forall props. ReactClass props
foreign import scrollViewClass :: forall props. ReactClass props

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
