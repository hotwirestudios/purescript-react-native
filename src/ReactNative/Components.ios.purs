module ReactNative.Components.IOS where

import Prelude
import React (ReactClass(), ReactElement())
import React.DOM.Props (Props(), unsafeMkProps, unsafeFromPropsArray)
import ReactNative.Components (createElement, createElementOneChild, createElementNoChild)
import ReactNative.Props.IOS (TabBarPropsIOS(..), TabBarItemPropsIOS(..), NavigationBarPropsIOS(..))
import ReactNative.Props (NavigatorRoute(..))

foreign import tabBarIOSClass :: forall props. ReactClass props
foreign import tabBarItemIOSClass :: forall props. ReactClass props
foreign import navigatorIOSClass :: forall props. ReactClass props

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

navigatorIOS :: Array NavigationBarPropsIOS -> Array Props -> NavigatorRoute -> ReactElement
navigatorIOS navigationBarProps props route = createElementNoChild navigatorIOSClass combinedProps
    where
        combinedProps = (map unwrap navigationBarProps) ++ props ++ ([unsafeMkProps "initialRoute" $ unwrap2 route])
        unwrap (NavigationBarPropsIOS n) = n
        unwrap2 (NavigatorRoute r) = {title: r.title, component: r.component, passProps: (unsafeFromPropsArray r.passProps)}
