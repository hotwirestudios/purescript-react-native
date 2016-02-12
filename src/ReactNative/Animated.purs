module ReactNative.Animated where

import Prelude (Unit)
import React (ReactClass, ReactElement)
import React.DOM.Props (Props)
import ReactNative.Components (createNativeElement)

foreign import animatedViewClass :: forall props. ReactClass props
foreign import animatedValue :: forall a. a -> AnimatedImplementation a

type InterpolationConfigType = {
    inputRange :: Array Number,
    outputRange :: Array Number
}

type AnimatedImplementation a = {
    interpolate :: InterpolationConfigType -> a,
    setValue :: a -> Unit
}

animatedView :: Array Props -> Array ReactElement -> ReactElement
animatedView = createNativeElement animatedViewClass
