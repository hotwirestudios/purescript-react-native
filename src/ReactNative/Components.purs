module ReactNative.Components where

import Prelude (Unit, (<$>), ($), bind, pure)
import Data.Array (snoc)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Nullable (Nullable, toNullable)
import Control.Monad.Eff (Eff)
import React (Event, EventHandler, EventHandlerContext, ReactElement, ReactProps, ReactThis, ReactClass, ReactSpec, handle, getProps)
import React.DOM.Props (Props, unsafeMkProps)

foreign import createNativeElement :: forall props. ReactClass props -> props -> Array ReactElement -> ReactElement
foreign import createNativeClass :: forall props state eff. ReactSpec props state eff -> ReactClass props
foreign import viewClass :: forall props. ReactClass props
foreign import imageClass :: forall props. ReactClass props
foreign import textElem :: String -> ReactElement
foreign import textClass :: forall props. ReactClass props
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

secureTextInput :: Array Props -> ReactElement
secureTextInput props = textInput combinedProps
    where
        combinedProps = snoc props $ unsafeMkProps "secureTextEntry" true

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

foreign import data Focus :: !
foreign import focus :: forall eff. ReactElement -> Eff (focus :: Focus | eff) Unit

foreign import data Alert :: !

newtype AlertButton = AlertButton
    { text :: String
    , onPress :: forall eff props state. (Event -> EventHandlerContext eff props state Unit)
    , style :: Maybe AlertButtonStyle
    }

data AlertButtonStyle = AlertButtonStyleDefault | AlertButtonStyleCancel | AlertButtonStyleDesctructive

type AlertButtonInternal =
    { text :: String
    , onPress :: EventHandler Event
    , style :: Nullable String
    }

foreign import showAlert :: forall eff. Nullable String -> Nullable String -> Array AlertButtonInternal -> Eff (alert :: Alert | eff) Unit

alert :: forall eff. Maybe String -> Maybe String -> Array AlertButton -> Eff (alert :: Alert | eff) Unit
alert title txt buttons = showAlert (toNullable title) (toNullable txt) $ convertButton <$> buttons
    where
        convertButton (AlertButton button) =
            { text: button.text
            , onPress: handle button.onPress
            , style: toNullable $
                case button.style of
                    Nothing -> Nothing
                    Just AlertButtonStyleDefault -> Just "default"
                    Just AlertButtonStyleCancel -> Just "cancel"
                    Just AlertButtonStyleDesctructive -> Just "destructive"
            }
