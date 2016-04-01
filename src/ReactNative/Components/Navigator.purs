module ReactNative.Components.Navigator where

import Prelude (Unit, unit, (==), ($), (<>), pure, bind)
import Data.Array (last, snoc)
import Data.Function (mkFn2)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Nullable (Nullable)
import Control.Monad.Eff (Eff)
import React (ReactElement, ReadWrite, ReactState, ReadOnly, ReactRefs, ReactProps, ReactThis, ReactClass, EventHandler, Event)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Styles (StyleProp, StyleId)
import ReactNative.Components (ComponentProps(ComponentProps), scrollViewClass, createNativeElement, passPropsToProps)

foreign import navigatorClass :: forall props. ReactClass props

type NavigatorChildProps a =
    { navigator :: ReactElement
    , appearing :: Appearing
    | a
    }

data Appearing = WillAppear | WillDisappear

foreign import data Navigate :: !

type NavigatorRouteType customProps props =
    { id :: String
    , title :: String
    , sceneConfig :: Maybe SceneConfig
    , component :: ReactClass (ComponentProps customProps (NavigatorChildProps props))
    , passProps :: ComponentProps customProps (NavigatorChildProps props)
    , rightButtonTitle :: Nullable String
    , onRightButtonPress :: Nullable (EventHandler Event)
    }

type ViewStateCallback eff result = Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite | eff) result

data NavigatorRoute customProps props = NavigatorRoute (NavigatorRouteType customProps props)

newtype Navigator eff = Navigator
    { push :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
    , replace :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
    , resetTo :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
    }

foreign import pushRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit
foreign import popRoute :: forall eff. ReactElement -> Eff (navigate :: Navigate | eff) Unit
foreign import replaceRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit
foreign import resetRoute :: forall route eff. ReactElement -> route -> Eff (navigate :: Navigate | eff) Unit

foreign import getCurrentRoutes :: forall customProps props. ReactElement -> Array (NavigatorRouteType customProps props)

foreign import getNavigationHelper :: forall props state eff eff1. ReactThis props state -> Eff (props :: ReactProps | eff) (Navigator eff1)

type NavigationHandler eff result = (ReactElement -> NavigationEvent -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) result)

navigationHelper :: forall eff result. NavigationHandler eff result -> Props
navigationHelper handler = unsafeMkProps "navigationHelper" navi
    where
        navi = (Navigator
                    { push: push
                    , replace: replace
                    , resetTo: resetTo
                    })
        push :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
        push element (NavigatorRoute r) = do
            pushRoute element $ adjustRoute r
            handler element Push
            pure unit
        replace :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
        replace element (NavigatorRoute r) = do
            replaceRoute element $ adjustRoute r
            handler element Replace
            pure unit
        resetTo :: forall customProps props. ReactElement -> NavigatorRoute customProps props -> Eff (props :: ReactProps, refs :: ReactRefs ReadOnly, state :: ReactState ReadWrite, navigate :: Navigate | eff) Unit
        resetTo element (NavigatorRoute r) = do
            resetRoute element $ adjustRoute r
            handler element Reset
            pure unit
        adjustRoute :: forall customProps props. NavigatorRouteType customProps props -> NavigatorRouteType customProps props
        adjustRoute r = r { passProps = passPropsToProps $ adjustPassProps r.passProps }
            where
                adjustPassProps (ComponentProps compProps) = ComponentProps (compProps {initialProps = snoc compProps.initialProps $ navigationHelper handler})

data NavigationEvent = Push | Replace | Reset

foreign import setNavigator :: forall customProps props. (ComponentProps customProps (NavigatorChildProps props)) -> ReactElement -> Appearing -> (ComponentProps customProps (NavigatorChildProps props))

navigator :: forall customProps props. NavigatorRoute customProps props -> (NavigatorRoute customProps props -> ReactElement -> ReactElement) -> Array Props -> ReactElement
navigator route render props =
    createNativeElement navigatorClass combinedProps []
    where
        combinedProps = props <> [initialRoute route, renderScene, configureScene]
        initialRoute (NavigatorRoute r) = unsafeMkProps "initialRoute" r
        renderScene = unsafeMkProps "renderScene" callback
        configureScene = unsafeMkProps "configureScene" sceneCallback
        sceneCallback = mkFn2 \r s -> toJSSceneConfig r.sceneConfig
        callback = mkFn2 $ \r n -> do
            let appearing = case last $ getCurrentRoutes n of
                                Just routeObj -> if routeObj.id == r.id then WillAppear else WillDisappear
                                Nothing -> WillDisappear
                nr = (NavigatorRoute (r {passProps = setNavigator r.passProps n appearing}))
            render nr n

foreign import data JSSceneConfig :: *
foreign import sceneConfigs :: Unit -> JSSceneConfigs

data SceneConfig = PushFromRight | FloatFromRight | FloatFromLeft | FloatFromBottom | FloatFromBottomAndroid | FadeAndroid | HorizontalSwipeJump | HorizontalSwipeJumpFromRight | VerticalUpSwipeJump | VerticalDownSwipeJump

toJSSceneConfig :: Maybe SceneConfig -> JSSceneConfig
toJSSceneConfig config = do
    let configs = sceneConfigs unit
    case config of
        Nothing -> configs.fadeAndroid
        Just PushFromRight -> configs.pushFromRight
        Just FloatFromRight -> configs.floatFromRight
        Just FloatFromLeft -> configs.floatFromLeft
        Just FloatFromBottom -> configs.floatFromBottom
        Just FloatFromBottomAndroid -> configs.floatFromBottomAndroid
        Just FadeAndroid -> configs.fadeAndroid
        Just HorizontalSwipeJump -> configs.horizontalSwipeJump
        Just HorizontalSwipeJumpFromRight -> configs.horizontalSwipeJumpFromRight
        Just VerticalUpSwipeJump -> configs.verticalUpSwipeJump
        Just VerticalDownSwipeJump -> configs.verticalDownSwipeJump

type JSSceneConfigs =
    { pushFromRight :: JSSceneConfig
    , floatFromRight :: JSSceneConfig
    , floatFromLeft :: JSSceneConfig
    , floatFromBottom :: JSSceneConfig
    , floatFromBottomAndroid :: JSSceneConfig
    , fadeAndroid :: JSSceneConfig
    , horizontalSwipeJump :: JSSceneConfig
    , horizontalSwipeJumpFromRight :: JSSceneConfig
    , verticalUpSwipeJump :: JSSceneConfig
    , verticalDownSwipeJump :: JSSceneConfig
    }

data ContentContainerStyle = ContentContainerStyleInline (Array StyleProp) | ContentContainerStyle StyleId

scrollView :: ContentContainerStyle -> Array Props -> Array ReactElement -> ReactElement
scrollView ccs props children = createNativeElement scrollViewClass (snoc props $ containerStyle ccs) children
    where
        containerStyle (ContentContainerStyleInline styleProps) = unsafeMkProps "contentContainerStyle" $ passPropsToProps styleProps
        containerStyle (ContentContainerStyle styleId) = unsafeMkProps "contentContainerStyle" $ styleId
