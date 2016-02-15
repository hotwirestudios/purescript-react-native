module ReactNative.Components.Android where

import Prelude (Unit)
import React (ReactElement, ReactClass)
import React.DOM.Props (Props)
import ReactNative.Components (createNativeElement)

foreign import touchableNativeFeedbackClass :: forall props. ReactClass props
foreign import viewPagerAndroidClass :: forall props. ReactClass props
foreign import setPage :: forall a. a -> Int -> Unit

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback props element = createNativeElement touchableNativeFeedbackClass props [element]

viewPagerAndroid :: Array Props -> Array ReactElement -> ReactElement
viewPagerAndroid = createNativeElement viewPagerAndroidClass
