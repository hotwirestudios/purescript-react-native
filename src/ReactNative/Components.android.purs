module ReactNative.Components.Android where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import React (ReactElement, ReactClass)
import React.DOM.Props (Props)
import ReactNative.Components (createNativeElement)

foreign import data PageChange :: !

foreign import touchableNativeFeedbackClass :: forall props. ReactClass props
foreign import viewPagerAndroidClass :: forall props. ReactClass props
foreign import setPage :: forall a eff. a -> Int -> Eff (page :: PageChange | eff) Unit
foreign import toolbarAndroidClass :: forall props. ReactClass props

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback props element = createNativeElement touchableNativeFeedbackClass props [element]

viewPagerAndroid :: Array Props -> Array ReactElement -> ReactElement
viewPagerAndroid = createNativeElement viewPagerAndroidClass

toolbarAndroid :: Array Props -> ReactElement
toolbarAndroid props = createNativeElement toolbarAndroidClass props []
