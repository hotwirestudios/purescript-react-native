module ReactNative.Props where

import Prelude (Unit, (<<<), ($))
import Control.Monad.Eff (Eff())
import Data.Function (mkFn3, mkFn4)
import React (ReactElement(), ReactClass, Event(), EventHandlerContext(), handle, ReactThis, Write, Read, ReactRefs)
import React.DOM.Props (Props(), unsafeMkProps)
import ReactNative.Components (ListViewDataSource())

type RenderRowFn = forall rowData highlightFn. rowData -> String -> String -> highlightFn -> ReactElement
type RenderSeparatorFn = String -> String -> Boolean -> ReactElement
type RenderHeaderFn = forall eff. Eff eff ReactElement
type OnPressFn = forall eff. Eff eff Unit
newtype AssetId = AssetId Int

foreign import unitFn :: forall a. a -> (Unit -> a)

renderRow :: forall rowData highlightFn. (rowData -> String -> String -> highlightFn -> ReactElement) -> Props
renderRow = unsafeMkProps "renderRow" <<< mkFn4

renderSeparator :: RenderSeparatorFn -> Props
renderSeparator fun = unsafeMkProps "renderSeparator" (mkFn3 fun)

renderHeader :: ReactElement -> Props
renderHeader elem = unsafeMkProps "renderHeader" (unitFn elem)

renderFooter :: ReactElement -> Props
renderFooter elem = unsafeMkProps "renderFooter" (unitFn elem)

dataSource :: ListViewDataSource -> Props
dataSource = unsafeMkProps "dataSource"

activeOpacity :: Number -> Props
activeOpacity = unsafeMkProps "activeOpacity"

onPress :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPress f = unsafeMkProps "onPress" (handle f)

onPressIn :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPressIn f = unsafeMkProps "onPressIn" (handle f)

onPressOut :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onPressOut f = unsafeMkProps "onPressOut" (handle f)

onSubmitEditing :: forall eff props state result. (Event -> EventHandlerContext eff props state result) -> Props
onSubmitEditing f = unsafeMkProps "onSubmitEditing" (handle f)

onChangeText :: forall eff props state result. (String -> EventHandlerContext eff props state result) -> Props
onChangeText f = unsafeMkProps "onChangeText" (handle f)

type LayoutEvent = {
    nativeEvent :: {
        layout :: {
            x :: Number,
            y :: Number,
            width :: Number,
            height :: Number}
    }
}

onLayout :: forall eff props state result. (LayoutEvent -> EventHandlerContext eff props state result) -> Props
onLayout f = unsafeMkProps "onLayout" (handle f)

data ComponentProps a = ComponentProps {
    customProps :: a,
    props :: Array Props
}

data NavigatorRoute props = NavigatorRoute {
    title :: String,
    component :: ReactClass props,
    passProps :: props
}

foreign import storeRef :: forall a props state eff. ReactThis props state -> String -> a -> Eff (refs :: ReactRefs (write :: Write) | eff) Unit
foreign import getRef :: forall props state eff. ReactThis props state -> String -> Eff (refs :: ReactRefs (read :: Read) | eff) ReactElement

ref :: forall a eff. (a -> Eff (refs :: ReactRefs (write :: Write) | eff) Unit) -> Props
ref = unsafeMkProps "ref"

ref' :: forall props state. ReactThis props state -> String -> Props
ref' key this = ref $ storeRef key this
