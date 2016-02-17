module ReactNative.Components.IOS where

import Prelude (Unit, ($), (++), map)
import Control.Monad.Eff (Eff)
import React (ReactClass, ReactElement, Write)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Components (NavigatorRoute(NavigatorRoute), createNativeElement)
import ReactNative.Props.IOS (TabBarPropsIOS(..), TabBarItemPropsIOS(..), NavigationBarPropsIOS(..))

foreign import tabBarIOSClass :: forall props. ReactClass props
foreign import tabBarItemIOSClass :: forall props. ReactClass props
foreign import navigatorIOSClass :: forall props. ReactClass props
foreign import setStatusBarStyleIOSImpl :: forall eff. String -> Eff (statusBarIOS :: StatusBarIOS (write :: Write) | eff) Unit

foreign import data StatusBarIOS :: # ! -> !

newtype TabBarItemIOS = TabBarItemIOS ReactElement

tabBarItemIOS :: Array TabBarItemPropsIOS -> Array Props -> ReactElement -> TabBarItemIOS
tabBarItemIOS tabBarItemProps props element = TabBarItemIOS $ createNativeElement tabBarItemIOSClass combinedProps [element]
    where
        combinedProps = (map unwrap tabBarItemProps) ++ props
        unwrap (TabBarItemPropsIOS p) = p

tabBarIOS :: Array TabBarPropsIOS -> Array Props -> Array TabBarItemIOS -> ReactElement
tabBarIOS tabBarProps props items = createNativeElement tabBarIOSClass combinedProps $ map unwrap2 items
    where
        combinedProps = (map unwrap tabBarProps) ++ props
        unwrap (TabBarPropsIOS p) = p
        unwrap2 (TabBarItemIOS i) = i

navigatorIOS :: forall a. Array NavigationBarPropsIOS -> Array Props -> NavigatorRoute a -> ReactElement
navigatorIOS navigationBarProps props route = createNativeElement navigatorIOSClass combinedProps []
    where
        combinedProps = (map unwrap navigationBarProps) ++ props ++ [unsafeMkProps "initialRoute" $ unwrap2 route]
        unwrap (NavigationBarPropsIOS n) = n
        unwrap2 (NavigatorRoute r) = r

data StatusBarStyleIOS = Default | LightContent

setStatusBarStyleIOS :: forall eff. StatusBarStyleIOS -> Eff (statusBarIOS :: StatusBarIOS (write :: Write) | eff) Unit
setStatusBarStyleIOS (Default) = setStatusBarStyleIOSImpl "default"
setStatusBarStyleIOS (LightContent) = setStatusBarStyleIOSImpl "light-content"
