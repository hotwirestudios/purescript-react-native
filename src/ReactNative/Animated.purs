module ReactNative.Animated where

import React (ReactClass, ReactElement)
import React.DOM.Props (Props)
import ReactNative.Components (createElement)

-- foreign import data AnimatedImplementation :: * -> *
foreign import data AnimatedInterpolation :: *

foreign import animatedViewClass :: forall props. ReactClass props

type InterpolationConfigType = {
    inputRange :: Array Number,
    outputRange :: Array Number
}

type AnimatedImplementation = {
    interpolate :: InterpolationConfigType -> Number
}

animatedView :: Array Props -> Array ReactElement -> ReactElement
animatedView = createElement animatedViewClass
