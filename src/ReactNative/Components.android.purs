module ReactNative.Components.Android where

import Prelude (Unit, (<>), ($))
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(Just, Nothing))
import React (ReactElement, ReactClass)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative (Color, colorToString)
import ReactNative.Components (createNativeElement)

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

toolbarAndroid :: Array Props -> ReactElement
toolbarAndroid props = createNativeElement toolbarAndroidClass props []

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
