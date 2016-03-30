module ReactNative.Props where

import Prelude (Unit, ($))
import Control.Monad.Eff (Eff)
import React (ReactThis, Write, ReactRefs, ReactElement, Read, EventHandlerContext, Event, handle)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative (Color, colorToString)

type OnPressFn = forall eff. Eff eff Unit
newtype AssetId = AssetId Int

activeOpacity :: Number -> Props
activeOpacity = unsafeMkProps "activeOpacity"

onPress :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPress f = unsafeMkProps "onPress" (handle f)

onPressIn :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPressIn f = unsafeMkProps "onPressIn" (handle f)

onPressOut :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPressOut f = unsafeMkProps "onPressOut" (handle f)

delayPressIn :: Number -> Props
delayPressIn = unsafeMkProps "delayPressIn"

delayPressOut :: Number -> Props
delayPressOut = unsafeMkProps "delayPressOut"

onSubmitEditing :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onSubmitEditing f = unsafeMkProps "onSubmitEditing" (handle f)

onChangeText :: forall eff props state result. (String -> EventHandlerContext eff props state result) -> Props
onChangeText f = unsafeMkProps "onChangeText" (handle f)

type LayoutEvent =
    { nativeEvent ::
        { layout ::
            { x :: Number
            , y :: Number
            , width :: Number
            , height :: Number
            }
        }
    }

onLayout :: forall eff props state result. (LayoutEvent -> EventHandlerContext eff props state result) -> Props
onLayout f = unsafeMkProps "onLayout" (handle f)

foreign import storeRef :: forall a props state eff. ReactThis props state -> String -> a -> Eff (refs :: ReactRefs (write :: Write) | eff) Unit
foreign import getRef :: forall props state access eff. ReactThis props state -> String -> Eff (refs :: ReactRefs (read :: Read | access) | eff) ReactElement
foreign import getRef_ :: forall props state access eff props1 state1. ReactThis props state -> String -> Eff (refs :: ReactRefs (read :: Read | access) | eff) (ReactThis props1 state1)

getRef' :: forall props state access eff props1 state1. ReactThis props state -> String -> Eff (refs :: ReactRefs (read :: Read | access) | eff) (ReactThis props1 state1)
getRef' = getRef_

ref :: forall a eff. (a -> Eff (refs :: ReactRefs (write :: Write) | eff) Unit) -> Props
ref = unsafeMkProps "ref"

ref' :: forall props state. ReactThis props state -> String -> Props
ref' key this = ref $ storeRef key this

titleColor :: Color -> Props
titleColor c = unsafeMkProps "titleColor" $ colorToString c

logo :: AssetId -> Props
logo (AssetId a) = unsafeMkProps "logo" a

contentInsetStart :: Number -> Props
contentInsetStart = unsafeMkProps "contentInsetStart"

subtitle :: String -> Props
subtitle = unsafeMkProps "subtitle"

subtitleColor :: Color -> Props
subtitleColor c = unsafeMkProps "subtitleColor" $ colorToString c

underlayColor :: Color -> Props
underlayColor c = unsafeMkProps "underlayColor" $ colorToString c

placeholder :: String -> Props
placeholder = unsafeMkProps "placeholder"

placeholderColor :: Color -> Props
placeholderColor c = unsafeMkProps "placeholderColor" $ colorToString c

data AssetSource = AssetSourceId AssetId | AssetSourceURI { uri :: String }

source :: AssetSource -> Props
source (AssetSourceId (AssetId a)) = unsafeMkProps "source" a
source (AssetSourceURI uri) = unsafeMkProps "source" uri

data ResizeMode = Cover | Contain | Stretch

resizeMode :: ResizeMode -> Props
resizeMode mode = unsafeMkProps "resizeMode" $
    case mode of
        Cover -> "cover"
        Contain -> "contain"
        Stretch -> "stretch"

data KeyboardType = KeyboardTypeDefault | KeyboardTypeEmailAddress | KeyboardTypeNumeric | KeyboardTypePhonePad | KeyboardTypeAsciiCapable | KeyboardTypeNumbers | KeyboardTypeUrl | KeyboardTypeNumberPad | KeyboardTypeNamePhonePad | KeyboardTypeDecimalPad | KeyboardTypeTwitter | KeyboardTypeWebSearch

keyboardType :: KeyboardType -> Props
keyboardType kt = unsafeMkProps "keyboardType" $
    case kt of
        KeyboardTypeDefault -> "default"
        KeyboardTypeEmailAddress -> "email-address"
        KeyboardTypeNumeric -> "numeric"
        KeyboardTypePhonePad -> "phone-pad"
        KeyboardTypeAsciiCapable -> "ascii-capable"
        KeyboardTypeNumbers -> "numbers-and-punctuation"
        KeyboardTypeUrl -> "url"
        KeyboardTypeNumberPad -> "number-pad"
        KeyboardTypeNamePhonePad -> "phone-pad"
        KeyboardTypeDecimalPad -> "decimal-pad"
        KeyboardTypeTwitter -> "twitter"
        KeyboardTypeWebSearch -> "web-search"

autoFocus :: Boolean -> Props
autoFocus = unsafeMkProps "autoFocus"

autoCorrect :: Boolean -> Props
autoCorrect = unsafeMkProps "autoCorrect"

data AutoCapitalize = AutoCapitalizeNone | AutoCapitalizeSentences | AutoCapitalizeWords | AutoCapitalizeCharacters

autoCapitalize :: AutoCapitalize -> Props
autoCapitalize ac = unsafeMkProps "autoCapitalize" $
    case ac of
        AutoCapitalizeNone -> "none"
        AutoCapitalizeSentences -> "sentences"
        AutoCapitalizeWords -> "words"
        AutoCapitalizeCharacters -> "characters"
