module ReactNative.Props.IOS where

import Prelude (($), (<<<))
import ReactNative (Color(..))
import React.DOM.Props (Props(), unsafeMkProps)

newtype TabBarPropsIOS = TabBarPropsIOS Props
newtype TabBarItemPropsIOS = TabBarItemPropsIOS Props
newtype NavigationBarPropsIOS = NavigationBarPropsIOS Props

tabBarTintColor :: Color -> TabBarPropsIOS
tabBarTintColor (Color c) = TabBarPropsIOS $ unsafeMkProps "tintColor" c

tabBarBarTintColor :: Color -> TabBarPropsIOS
tabBarBarTintColor (Color c) = TabBarPropsIOS $ unsafeMkProps "barTintColor" c

tabSelected :: Boolean -> TabBarItemPropsIOS
tabSelected = TabBarItemPropsIOS <<< unsafeMkProps "selected"

tabBarTranslucent :: Boolean -> TabBarItemPropsIOS
tabBarTranslucent = TabBarItemPropsIOS <<< unsafeMkProps "translucent"

navigationBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarTintColor (Color c) = NavigationBarPropsIOS $ unsafeMkProps "tintColor" c

navigationBarBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarBarTintColor (Color c) = NavigationBarPropsIOS $ unsafeMkProps "barTintColor" c

navigationBarTranslucent :: Boolean -> NavigationBarPropsIOS
navigationBarTranslucent = NavigationBarPropsIOS <<< unsafeMkProps "translucent"
