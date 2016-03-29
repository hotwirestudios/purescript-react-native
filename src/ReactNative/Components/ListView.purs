module ReactNative.Components.ListView where

import Prelude (class Eq, Unit, (<>), ($))
import Data.StrMap (StrMap)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.Function (mkFn2, mkFn3, mkFn4)
import Data.Maybe (Maybe(Nothing, Just))
import Data.Nullable (Nullable, toNullable)
import React (ReactElement, ReactClass)
import React.DOM.Props (Props, unsafeMkProps)
import ReactNative.Components (createNativeElement)

type HighlightRowFn rowData = Maybe rowData -> Unit
type HighlightRowFn_ rowData = Nullable rowData -> Unit
type RenderRowFn rowData eff = rowData -> String -> String -> HighlightRowFn rowData -> Eff eff ReactElement
type RenderRowFn_ rowData = rowData -> String -> String -> HighlightRowFn_ rowData -> ReactElement
type RenderSectionHeaderFn sectionData eff = sectionData -> String -> Eff eff ReactElement
type RenderSectionHeaderFn_ sectionData = sectionData -> String -> ReactElement
type RenderHeaderFooterFn = ReactElement
type RenderSeparatorFn = String -> String -> Boolean -> ReactElement

foreign import listViewClass :: forall props. ReactClass props
foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource a
foreign import listViewDataSourceWithSections :: forall a. (Eq a) => StrMap (Array a) -> ListViewDataSource a
foreign import cloneWithRows :: forall a. ListViewDataSource a -> Array a -> ListViewDataSource a
foreign import cloneWithRowsAndSections :: forall a. ListViewDataSource a -> StrMap (Array a) -> ListViewDataSource a
foreign import unitFn :: forall a. a -> (Unit -> a)

foreign import data ListViewDataSource :: * -> *

newtype RenderListView sectionData rowData eff = RenderListView
    { row :: RenderRowFn rowData eff
    , sectionHeader :: Maybe (RenderSectionHeaderFn sectionData eff)
    , separator :: Maybe RenderSeparatorFn
    , header :: Maybe RenderHeaderFooterFn
    , footer :: Maybe RenderHeaderFooterFn
    }

listView :: forall sectionData rowData eff. ListViewDataSource rowData -> RenderListView sectionData rowData eff -> Array Props -> ReactElement
listView ds (RenderListView render) props = createNativeElement listViewClass
    ( [unsafeMkProps "dataSource" ds, unsafeRenderRow render.row]
    <> (renderSectionHeader render.sectionHeader)
    <> (renderSeparator render.separator)
    <> (renderHeaderFooter render.header "renderHeader")
    <> (renderHeaderFooter render.footer "renderFooter")
    <> props
    )
    []
    where
        renderSeparator (Just separator) = [unsafeMkProps "renderSeparator" (mkFn3 separator)]
        renderSeparator Nothing = []

        renderSectionHeader (Just sectionHeader) = [unsafeMkProps "renderSectionHeader" (mkFn2 $ sectionHeader_ sectionHeader)]
        renderSectionHeader Nothing = []

        sectionHeader_ :: RenderSectionHeaderFn sectionData eff -> RenderSectionHeaderFn_ sectionData
        sectionHeader_ sectionHeader sectionData sectionId = unsafePerformEff $ sectionHeader sectionData sectionId

        renderHeaderFooter (Just element) name = [unsafeMkProps name (unitFn element)]
        renderHeaderFooter Nothing _ = []

        unsafeRenderRow :: RenderRowFn rowData eff -> Props
        unsafeRenderRow fn = unsafeMkProps "renderRow" $ mkFn4 fn_
            where
                fn_ :: RenderRowFn_ rowData
                fn_ rowData sectionId rowId highlightFn = unsafePerformEff $ fn rowData sectionId rowId (highlight highlightFn)
                highlight :: HighlightRowFn_ rowData -> HighlightRowFn rowData
                highlight highlightFn val = highlightFn $ toNullable val
