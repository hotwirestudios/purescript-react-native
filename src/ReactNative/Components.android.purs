module ReactNative.Components.Android where

import React (ReactClass(), ReactElement())
import React.DOM.Props (Props())
import ReactNative.Components (createNativeElement)

foreign import touchableNativeFeedbackClass :: forall props. ReactClass props

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback props element = createNativeElement touchableNativeFeedbackClass props [element]
