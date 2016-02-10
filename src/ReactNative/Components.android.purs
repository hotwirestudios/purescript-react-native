module ReactNative.Components.Android where

import React (ReactClass(), ReactElement())
import React.DOM.Props (Props())
import ReactNative.Components (createElementOneChild)

foreign import touchableNativeFeedbackClass :: forall props. ReactClass props

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback = createElementOneChild touchableNativeFeedbackClass
