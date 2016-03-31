module ReactNative.Components.IOS where

import Prelude (Unit, ($), (++), map, (<>))
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(Just, Nothing))
import React (ReactClass, ReactElement, Write)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative (Color, colorToString)
import ReactNative.Components (createNativeElement, passPropsToProps)
import ReactNative.Components.Navigator (NavigatorRoute(NavigatorRoute))
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

navigatorIOS :: forall customProps props. Array NavigationBarPropsIOS -> Array Props -> NavigatorRoute customProps props -> ReactElement
navigatorIOS navigationBarProps props route = createNativeElement navigatorIOSClass combinedProps []
    where
        combinedProps = (map unwrap navigationBarProps) ++ props ++ [unsafeMkProps "initialRoute" $ unwrap2 route]
        unwrap (NavigationBarPropsIOS n) = n
        unwrap2 (NavigatorRoute r) = r { passProps = passPropsToProps r.passProps }

data StatusBarStyleIOS = Default | LightContent

setStatusBarStyleIOS :: forall eff. StatusBarStyleIOS -> Eff (statusBarIOS :: StatusBarIOS (write :: Write) | eff) Unit
setStatusBarStyleIOS (Default) = setStatusBarStyleIOSImpl "default"
setStatusBarStyleIOS (LightContent) = setStatusBarStyleIOSImpl "light-content"

foreign import activityIndicatorIOSClass :: forall props. ReactClass props

type ActivityIndicatorIOSProps =
    { animating :: Maybe Boolean
    , color :: Maybe Color
    , hidesWhenStopped :: Maybe Boolean
    , size :: Maybe ActivityIndicatorIOSSize
    }

data ActivityIndicatorIOSSize = ActivityIndicatorIOSSizeSmall | ActivityIndicatorIOSSizeLarge

activityIndicatorIOSProps :: ActivityIndicatorIOSProps
activityIndicatorIOSProps =
    { animating: Nothing
    , color: Nothing
    , hidesWhenStopped: Nothing
    , size: Nothing
    }

activityIndicatorIOS :: ActivityIndicatorIOSProps -> Array Props -> ReactElement
activityIndicatorIOS customProps props = createNativeElement activityIndicatorIOSClass combinedProps []
    where
        combinedProps = props <>
            case customProps.animating of
                Nothing -> []
                Just animating -> [unsafeMkProps "animating" animating]
            <>
            case customProps.color of
                Nothing -> []
                Just color -> [unsafeMkProps "color" $ colorToString color]
            <>
            case customProps.hidesWhenStopped of
                Nothing -> []
                Just hidesWhenStopped -> [unsafeMkProps "hidesWhenStopped" hidesWhenStopped]
            <>
            case customProps.size of
                Nothing -> []
                Just size ->
                    [ unsafeMkProps "size" $
                        case size of
                            ActivityIndicatorIOSSizeSmall -> "small"
                            ActivityIndicatorIOSSizeLarge -> "large"
                    ]
