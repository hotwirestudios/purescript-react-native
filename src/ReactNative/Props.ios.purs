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

tabBarTranslucent :: Boolean -> TabBarPropsIOS
tabBarTranslucent = TabBarPropsIOS <<< unsafeMkProps "translucent"

tabSelected :: Boolean -> TabBarItemPropsIOS
tabSelected = TabBarItemPropsIOS <<< unsafeMkProps "selected"

navigationBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarTintColor (Color c) = NavigationBarPropsIOS $ unsafeMkProps "tintColor" c

navigationBarTitleTextColor :: Color -> NavigationBarPropsIOS
navigationBarTitleTextColor (Color c) = NavigationBarPropsIOS $ unsafeMkProps "titleTextColor" c

navigationBarBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarBarTintColor (Color c) = NavigationBarPropsIOS $ unsafeMkProps "barTintColor" c

navigationBarTranslucent :: Boolean -> NavigationBarPropsIOS
navigationBarTranslucent = NavigationBarPropsIOS <<< unsafeMkProps "translucent"
