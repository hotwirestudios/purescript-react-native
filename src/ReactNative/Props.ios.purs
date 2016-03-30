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

data ClearButtonMode = ClearButtonModeNever | ClearButtonModeWhileEditing | ClearButtonModeUnlessEditing | ClearButtonModeAlways

clearButtonMode :: ClearButtonMode -> Props
clearButtonMode mode = unsafeMkProps "clearButtonMode" $
    case mode of
        ClearButtonModeNever -> "never"
        ClearButtonModeWhileEditing -> "while-editing"
        ClearButtonModeUnlessEditing -> "unless-editing"
        ClearButtonModeAlways -> "always"

clearTextOnFocus :: Boolean -> Props
clearTextOnFocus = unsafeMkProps "clearTextOnFocus"

enablesReturnKeyAutomatically :: Boolean -> Props
enablesReturnKeyAutomatically = unsafeMkProps "enablesReturnKeyAutomatically"

data KeyboardAppearance = KeyboardAppearanceDefault | KeyboardAppearanceLight | KeyboardAppearanceDark

keyboardAppearance :: KeyboardAppearance -> Props
keyboardAppearance appearance = unsafeMkProps "keyboardAppearance" $
    case appearance of
        KeyboardAppearanceDefault -> "default"
        KeyboardAppearanceLight -> "light"
        KeyboardAppearanceDark -> "dark"

data ReturnKeyType = ReturnKeyTypeDefault | ReturnKeyTypeGo | ReturnKeyTypeGoogle | ReturnKeyTypeJoin | ReturnKeyTypeNext | ReturnKeyTypeRoute | ReturnKeyTypeSearch | ReturnKeyTypeSend | ReturnKeyTypeYahoo | ReturnKeyTypeDone | ReturnKeyTypeEmergencyCall

returnKeyType :: ReturnKeyType -> Props
returnKeyType keyType = unsafeMkProps "returnKeyType" $
    case keyType of
        ReturnKeyTypeDefault -> "default"
        ReturnKeyTypeGo -> "go"
        ReturnKeyTypeGoogle -> "google"
        ReturnKeyTypeJoin -> "join"
        ReturnKeyTypeNext -> "next"
        ReturnKeyTypeRoute -> "route"
        ReturnKeyTypeSearch -> "search"
        ReturnKeyTypeSend -> "send"
        ReturnKeyTypeYahoo -> "yahoo"
        ReturnKeyTypeDone -> "done"
        ReturnKeyTypeEmergencyCall -> "emergency-call"

selectTextOnFocus :: Boolean -> Props
selectTextOnFocus = unsafeMkProps "selectTextOnFocus"
