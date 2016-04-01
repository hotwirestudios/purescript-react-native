module ReactNative.Animated where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
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

foreign import data Animation :: !

data LayoutAnimation = Spring | Linear | EaseInEaseOut | EaseIn | EaseOut | Keyboard

foreign import spring :: forall eff. Eff (animation :: Animation | eff) Unit
foreign import linear :: forall eff. Eff (animation :: Animation | eff) Unit
foreign import easeInEaseOut :: forall eff. Eff (animation :: Animation | eff) Unit
foreign import easeIn :: forall eff. Eff (animation :: Animation | eff) Unit
foreign import easeOut :: forall eff. Eff (animation :: Animation | eff) Unit
foreign import keyboard :: forall eff. Eff (animation :: Animation | eff) Unit

animateLayoutChanges :: forall eff. LayoutAnimation -> Eff (animation :: Animation | eff) Unit
animateLayoutChanges anim =
    case anim of
        Spring -> spring
        Linear -> linear
        EaseInEaseOut -> easeInEaseOut
        EaseIn -> easeIn
        EaseOut -> easeOut
        Keyboard -> keyboard
