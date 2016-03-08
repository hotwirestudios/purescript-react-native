module ReactNative.Components.ListView where

import Prelude (class Eq, Unit, ($), (<>), pure)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Function (mkFn3, mkFn4)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Nullable (Nullable, toNullable)
import React (ReactElement)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Components (listViewClass, createNativeElement)

type HighlightRowFn rowData = Maybe rowData -> Unit
type HighlightRowFn_ rowData = Nullable rowData -> Unit
type RenderRowFn rowData eff = rowData -> String -> String -> HighlightRowFn rowData -> Eff eff ReactElement
type RenderRowFn_ rowData = rowData -> String -> String -> HighlightRowFn_ rowData -> ReactElement
type RenderHeaderFooterFn = ReactElement
type RenderSeparatorFn = String -> String -> Boolean -> ReactElement

foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource a
foreign import cloneWithRows :: forall a. ListViewDataSource a -> Array a -> ListViewDataSource a
foreign import unitFn :: forall a. a -> (Unit -> a)

foreign import data ListViewDataSource :: * -> *

newtype RenderListView rowData eff = RenderListView
    { row :: RenderRowFn rowData eff
    , separator :: Maybe RenderSeparatorFn
    , header :: Maybe RenderHeaderFooterFn
    , footer :: Maybe RenderHeaderFooterFn
    }

listView :: forall rowData eff. ListViewDataSource rowData -> RenderListView rowData eff -> Array Props -> ReactElement
listView ds (RenderListView render) props = createNativeElement listViewClass
    ( [unsafeMkProps "dataSource" ds, unsafeRenderRow render.row]
    <> (renderSeparator render.separator)
    <> (renderHeaderFooter render.header "renderHeader")
    <> (renderHeaderFooter render.footer "renderFooter")
    <> props
    )
    []
    where
        renderSeparator (Just separator) = [unsafeMkProps "renderSeparator" (mkFn3 separator)]
        renderSeparator Nothing = []

        renderHeaderFooter (Just element) name = [unsafeMkProps name (unitFn element)]
        renderHeaderFooter Nothing _ = []

        unsafeRenderRow :: RenderRowFn rowData eff -> Props
        unsafeRenderRow fn = unsafeMkProps "renderRow" $ mkFn4 fn_
            where
                fn_ :: RenderRowFn_ rowData
                fn_ rowData sectionId rowId highlightFn = unsafePerformEff $ fn rowData sectionId rowId (highlight highlightFn)
                highlight :: HighlightRowFn_ rowData -> HighlightRowFn rowData
                highlight highlightFn val = highlightFn $ toNullable val
