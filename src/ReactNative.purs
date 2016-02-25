module ReactNative where

import Prelude (Unit, (++), ($))
import Control.Monad.Eff (Eff())
import React (ReactClass())

type AppKey = String
foreign import registerComponent :: forall e props. AppKey -> ReactClass props -> Eff e Unit

newtype Color = Color String

colorWithAlpha :: Color -> String -> Color
colorWithAlpha (Color color) string = Color $ color ++ string

foreign import platformOS :: String

data PlatformOS = IOS | Android

currentPlatformOS :: PlatformOS
currentPlatformOS =
    case platformOS of
        "android" -> Android
        _ -> IOS

platformDependentValue :: forall a. a -> a -> a
platformDependentValue ios android = case currentPlatformOS of
                                        IOS -> ios
                                        Android -> android
