module ReactNative.Android where

import Prelude (class Ord, compare, class Eq, eq)

foreign import sdkVersion_ :: Int

newtype SdkVersion = SdkVersion Int

sdkVersion :: SdkVersion
sdkVersion = SdkVersion sdkVersion_

instance eqSdkVersion :: Eq SdkVersion where
    eq (SdkVersion a) (SdkVersion b) = eq a b

instance ordSdkVersion :: Ord SdkVersion where
    compare (SdkVersion a) (SdkVersion b) = compare a b
