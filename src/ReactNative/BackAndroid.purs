module ReactNative.BackAndroid where

import Prelude (Unit)
import React (ReactThis, EventHandlerContext)

foreign import addHardwareBackPressListener :: forall eff props state. (Unit -> EventHandlerContext eff props state Boolean) -> Unit

registerBackPressListener :: forall eff props state. ReactThis props state -> (ReactThis props state -> EventHandlerContext eff props state Boolean) -> Unit
registerBackPressListener ctx listener = addHardwareBackPressListener \_ -> listener ctx
