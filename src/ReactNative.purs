module ReactNative where

import Prelude
import Control.Monad.Eff (Eff())
import React (ReactClass())

type AppKey = String
foreign import registerComponent :: forall e props. AppKey -> ReactClass props -> Eff e Unit

newtype Color = Color String

colorWithAlpha :: Color -> String -> Color
colorWithAlpha (Color color) string = Color $ color ++ string
