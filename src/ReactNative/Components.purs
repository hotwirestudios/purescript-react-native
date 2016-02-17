module ReactNative.Components where

import Prelude (class Eq, Unit)
import Data.Maybe (Maybe)
import Control.Monad.Eff (Eff)
import React (ReactClass, ReactElement, ReactRefs, ReactProps, ReadOnly)
import React.DOM.Props (Props)
import ReactNative.Props (ListViewDataSource)

foreign import createNativeElement :: forall props. ReactClass props -> props -> Array ReactElement -> ReactElement
foreign import viewClass :: forall props. ReactClass props
foreign import textElem :: String -> ReactElement
foreign import textClass :: forall props. ReactClass props
foreign import listViewClass :: forall props. ReactClass props
foreign import touchableHighlightClass :: forall props. ReactClass props
foreign import touchableOpacityClass :: forall props. ReactClass props
foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource
foreign import cloneWithRows :: forall a. ListViewDataSource -> Array a -> ListViewDataSource
foreign import textInputClass :: forall props. ReactClass props

view :: Array Props -> Array ReactElement -> ReactElement
view = createNativeElement viewClass

text :: Array Props -> String -> ReactElement
text props str = createNativeElement textClass props [textElem str]

textView :: Array Props -> Array ReactElement -> ReactElement
textView = createNativeElement textClass

listView :: Array Props -> ReactElement
listView props = createNativeElement listViewClass props []

touchableHighlight :: Array Props -> ReactElement -> ReactElement
touchableHighlight props element = createNativeElement touchableHighlightClass props [element]

touchableOpacity :: Array Props -> ReactElement -> ReactElement
touchableOpacity props element = createNativeElement touchableOpacityClass props [element]

textInput :: Array Props -> ReactElement
textInput props = createNativeElement textInputClass props []

data ComponentProps customProps props = ComponentProps
    { customProps :: customProps
    , props :: Array Props
    , standardProps :: forall eff. Eff (refs :: ReactRefs ReadOnly, p :: ReactProps | eff) (Maybe props)
    }

data NavigatorRoute props = NavigatorRoute
    { title :: String
    , component :: ReactClass props
    , passProps :: props
    }
