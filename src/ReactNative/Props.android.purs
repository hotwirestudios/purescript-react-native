module ReactNative.Props.Android where

import React.DOM.Props (Props(), unsafeMkProps)

foreign import data NativeFeedbackBackground :: *
foreign import selectableBackground :: NativeFeedbackBackground
foreign import selectableBackgroundBorderless :: NativeFeedbackBackground

background :: NativeFeedbackBackground -> Props
background = unsafeMkProps "background"
