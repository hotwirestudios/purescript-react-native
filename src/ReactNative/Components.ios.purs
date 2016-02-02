module ReactNative.Components.IOS where

import Prelude
import React (ReactClass(), ReactElement())
import React.DOM.Props (Props())
import ReactNative.Components (createElement, createElementOneChild)
import ReactNative.Props.IOS (TabBarPropsIOS(..), TabBarItemPropsIOS(..))

foreign import tabBarIOSClass :: forall props. ReactClass props
foreign import tabBarItemIOSClass :: forall props. ReactClass props

newtype TabBarItemIOS = TabBarItemIOS ReactElement

tabBarItemIOS :: Array TabBarItemPropsIOS -> Array Props -> ReactElement -> TabBarItemIOS
tabBarItemIOS tabBarItemProps props = TabBarItemIOS <<< createElementOneChild tabBarItemIOSClass combinedProps
    where
        combinedProps = (map unwrap tabBarItemProps) ++ props
        unwrap (TabBarItemPropsIOS p) = p

tabBarIOS :: Array TabBarPropsIOS -> Array Props -> Array TabBarItemIOS -> ReactElement
tabBarIOS tabBarProps props items = createElement tabBarIOSClass combinedProps $ map unwrap2 items
    where
        combinedProps = (map unwrap tabBarProps) ++ props
        unwrap (TabBarPropsIOS p) = p
        unwrap2 (TabBarItemIOS i) = i

-- <TabBarIOS tintColor={Colors.iOS.tabBarTitleColor}
--                            barTintColor={Colors.iOS.tabBarColor}
--                            translucent={false}>