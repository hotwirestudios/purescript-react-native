module ReactNative.Props.Android where

import Prelude (($), unit, Unit)
import React (EventHandlerContext, handle)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative (Color, colorToString)

foreign import data NativeFeedbackBackground :: *
foreign import selectableBackground_ :: Unit -> NativeFeedbackBackground
foreign import selectableBackgroundBorderless_ :: Unit -> NativeFeedbackBackground
foreign import ripple_ :: String -> Boolean -> NativeFeedbackBackground

background :: NativeFeedbackBackground -> Props
background = unsafeMkProps "background"

selectableBackground :: NativeFeedbackBackground
selectableBackground = selectableBackground_ unit

selectableBackgroundBorderless :: NativeFeedbackBackground
selectableBackgroundBorderless = selectableBackgroundBorderless_ unit

ripple :: Color -> Boolean -> NativeFeedbackBackground
ripple c = ripple_ $ colorToString c

initialPage :: Int -> Props
initialPage = unsafeMkProps "initialPage"

type PageSelectedEvent =
    { nativeEvent ::
        { position :: Int
        }
    }

onPageSelected :: forall eff props state result. (PageSelectedEvent -> EventHandlerContext eff props state result) -> Props
onPageSelected f = unsafeMkProps "onPageSelected" (handle f)

type PageScrollEvent =
    { nativeEvent ::
        { offset :: Number
        , position :: Int
        }
    }

onPageScroll :: forall eff props state result. (PageScrollEvent -> EventHandlerContext eff props state result) -> Props
onPageScroll f = unsafeMkProps "onPageScroll" (handle f)

underlineColorAndroid :: Color -> Props
underlineColorAndroid c = unsafeMkProps "underlineColorAndroid" $ colorToString c
