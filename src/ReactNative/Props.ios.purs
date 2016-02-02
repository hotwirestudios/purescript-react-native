module ReactNative.Props.IOS where

import Prelude (($), (<<<))
import ReactNative (Color(..))
import React.DOM.Props (Props(), unsafeMkProps)

newtype TabBarPropsIOS = TabBarPropsIOS Props
newtype TabBarItemPropsIOS = TabBarItemPropsIOS Props

tabBarTintColor :: Color -> TabBarPropsIOS
tabBarTintColor (Color c) = TabBarPropsIOS $ unsafeMkProps "tintColor" c

selected :: Boolean -> TabBarItemPropsIOS
selected = TabBarItemPropsIOS <<< unsafeMkProps "selected"
