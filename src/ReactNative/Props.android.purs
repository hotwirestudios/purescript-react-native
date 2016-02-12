module ReactNative.Props.Android where

import React (EventHandlerContext, handle)
import React.DOM.Props (Props, unsafeMkProps)

foreign import data NativeFeedbackBackground :: *
foreign import selectableBackground :: NativeFeedbackBackground
foreign import selectableBackgroundBorderless :: NativeFeedbackBackground

background :: NativeFeedbackBackground -> Props
background = unsafeMkProps "background"

initialPage :: Int -> Props
initialPage = unsafeMkProps "initialPage"

type PageSelectedEvent = {
    nativeEvent :: {
        position :: Int
    }
}

onPageSelected :: forall eff props state result. (PageSelectedEvent -> EventHandlerContext eff props state result) -> Props
onPageSelected f = unsafeMkProps "onPageSelected" (handle f)

type PageScrollEvent = {
    nativeEvent :: {
        offset :: Number,
        position :: Int
    }
}

onPageScroll :: forall eff props state result. (PageScrollEvent -> EventHandlerContext eff props state result) -> Props
onPageScroll f = unsafeMkProps "onPageScroll" (handle f)
