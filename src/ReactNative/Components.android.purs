module ReactNative.Components.Android where

import Prelude (Unit, (<>), ($), (<$>))
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(Just, Nothing))
import Data.Nullable (Nullable, toNullable)
import React (ReactElement, ReactClass, EventHandlerContext, handle)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative (Color, colorToString)
import ReactNative.Components (createNativeElement)
import ReactNative.Props (AssetId)

foreign import data PageChange :: !

foreign import touchableNativeFeedbackClass :: forall props. ReactClass props
foreign import viewPagerAndroidClass :: forall props. ReactClass props
foreign import setPage :: forall a eff. a -> Int -> Eff (page :: PageChange | eff) Unit
foreign import toolbarAndroidClass :: forall props. ReactClass props
foreign import progressBarAndroidClass :: forall props. ReactClass props

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback props element = createNativeElement touchableNativeFeedbackClass props [element]

viewPagerAndroid :: Array Props -> Array ReactElement -> ReactElement
viewPagerAndroid = createNativeElement viewPagerAndroidClass

data ToolbarAndroidActionShow = ToolbarAndroidActionShowAlways | ToolbarAndroidActionShowIfRoom | ToolbarAndroidActionShowNever

type ToolbarAndroidAction =
    { title :: String
    , icon :: Maybe AssetId
    , show :: Maybe ToolbarAndroidActionShow
    , showWithText :: Maybe Boolean
    }

toolbarAndroidAction :: String -> ToolbarAndroidAction
toolbarAndroidAction title =
    { title: title
    , icon: Nothing
    , show: Nothing
    , showWithText: Nothing
    }

type ToolbarAndroidActionInternal =
    { title :: String
    , icon :: Nullable AssetId
    , show :: Nullable String
    , showWithText :: Nullable Boolean
    }

type ToolbarAndroidProps =
    { actions :: Array ToolbarAndroidAction
    , onActionSelected :: forall eff props state. Maybe (Int -> EventHandlerContext eff props state Unit)
    }

toolbarAndroidProps :: ToolbarAndroidProps
toolbarAndroidProps =
    { actions: []
    , onActionSelected: Nothing
    }

foreign import stripNullProps :: forall a b. a -> b

toolbarAndroid :: ToolbarAndroidProps -> Array Props -> ReactElement
toolbarAndroid barProps props = createNativeElement toolbarAndroidClass combinedProps []
    where
        combinedProps = props <>
            [unsafeMkProps "actions" $ convertAction <$> barProps.actions] <>
            actionSelected

        actionSelected =
            case barProps.onActionSelected of
                Nothing -> []
                Just f -> [unsafeMkProps "onActionSelected" $ handle f]

        convertAction :: ToolbarAndroidAction -> ToolbarAndroidActionInternal
        convertAction action = stripNullProps
            { title: action.title
            , icon: toNullable action.icon
            , show: toNullable $
                case action.show of
                    Nothing -> Nothing
                    Just ToolbarAndroidActionShowAlways -> Just "always"
                    Just ToolbarAndroidActionShowIfRoom -> Just "ifRoom"
                    Just ToolbarAndroidActionShowNever -> Just "never"
            , showWithText: toNullable action.showWithText
            }

type ProgressBarAndroidProps =
    { progress :: Maybe Number
    , indeterminate :: Maybe Boolean
    , color :: Maybe Color
    , styleAttr :: Maybe ProgressBarAndroidStyleAttribute
    }

data ProgressBarAndroidStyleAttribute = ProgressBarAndroidStyleAttributeHorizontal | ProgressBarAndroidStyleAttributeNormal | ProgressBarAndroidStyleAttributeSmall | ProgressBarAndroidStyleAttributeLarge | ProgressBarAndroidStyleAttributeInverse | ProgressBarAndroidStyleAttributeSmallInverse | ProgressBarAndroidStyleAttributeLargeInverse

progressBarAndroidProps :: ProgressBarAndroidProps
progressBarAndroidProps =
    { progress: Nothing
    , indeterminate: Nothing
    , color: Nothing
    , styleAttr: Nothing
    }

progressBarAndroid :: ProgressBarAndroidProps -> Array Props -> ReactElement
progressBarAndroid barProps props = createNativeElement progressBarAndroidClass combinedProps []
    where
        combinedProps = props <>
            case barProps.progress of
                Nothing -> []
                Just progress -> [unsafeMkProps "progress" progress]
            <>
            case barProps.indeterminate of
                Nothing -> []
                Just indeterminate -> [unsafeMkProps "indeterminate" indeterminate]
            <>
            case barProps.color of
                Nothing -> []
                Just color -> [unsafeMkProps "color" $ colorToString color]
            <>
            case barProps.styleAttr of
                Nothing -> []
                Just styleAttr ->
                    [ unsafeMkProps "styleAttr" $
                        case styleAttr of
                            ProgressBarAndroidStyleAttributeHorizontal -> "Horizontal"
                            ProgressBarAndroidStyleAttributeNormal -> "Normal"
                            ProgressBarAndroidStyleAttributeSmall -> "Small"
                            ProgressBarAndroidStyleAttributeLarge -> "Large"
                            ProgressBarAndroidStyleAttributeInverse -> "Inverse"
                            ProgressBarAndroidStyleAttributeSmallInverse -> "SmallInverse"
                            ProgressBarAndroidStyleAttributeLargeInverse -> "LargeInverse"
                    ]
