module ReactNative.Props.IOS where

import Prelude (($), (<<<))
import ReactNative (Color, colorToString)
import React.DOM.Props (Props(), unsafeMkProps)
import ReactNative.Props (AssetId)

newtype TabBarPropsIOS = TabBarPropsIOS Props
newtype TabBarItemPropsIOS = TabBarItemPropsIOS Props
newtype NavigationBarPropsIOS = NavigationBarPropsIOS Props

tabBarTintColor :: Color -> TabBarPropsIOS
tabBarTintColor c = TabBarPropsIOS $ unsafeMkProps "tintColor" $ colorToString c

tabBarBarTintColor :: Color -> TabBarPropsIOS
tabBarBarTintColor c = TabBarPropsIOS $ unsafeMkProps "barTintColor" $ colorToString c

tabBarTranslucent :: Boolean -> TabBarPropsIOS
tabBarTranslucent = TabBarPropsIOS <<< unsafeMkProps "translucent"

tabBarItemIcon :: AssetId -> TabBarItemPropsIOS
tabBarItemIcon = TabBarItemPropsIOS <<< unsafeMkProps "icon"

tabSelected :: Boolean -> TabBarItemPropsIOS
tabSelected = TabBarItemPropsIOS <<< unsafeMkProps "selected"

navigationBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarTintColor c = NavigationBarPropsIOS $ unsafeMkProps "tintColor" $ colorToString c

navigationBarTitleTextColor :: Color -> NavigationBarPropsIOS
navigationBarTitleTextColor c = NavigationBarPropsIOS $ unsafeMkProps "titleTextColor" $ colorToString c

navigationBarBarTintColor :: Color -> NavigationBarPropsIOS
navigationBarBarTintColor c = NavigationBarPropsIOS $ unsafeMkProps "barTintColor" $ colorToString c

navigationBarTranslucent :: Boolean -> NavigationBarPropsIOS
navigationBarTranslucent = NavigationBarPropsIOS <<< unsafeMkProps "translucent"
