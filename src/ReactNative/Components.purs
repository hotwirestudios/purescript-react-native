module ReactNative.Components where

import Prelude
import React (ReactClass(), ReactElement())
import React.DOM.Props (Props())

foreign import data ListViewDataSource :: *

foreign import createElement :: forall props. ReactClass props -> props -> Array ReactElement -> ReactElement
foreign import createElementOneChild :: forall props. ReactClass props -> props -> ReactElement -> ReactElement
foreign import viewClass :: forall props. ReactClass props
foreign import textElem :: String -> ReactElement
foreign import textClass :: forall props. ReactClass props
foreign import listViewClass :: forall props. ReactClass props
foreign import touchableHighlightClass :: forall props. ReactClass props
foreign import touchableNativeFeedbackClass :: forall props. ReactClass props
foreign import listViewDataSource :: forall a. (Eq a) => Array a -> ListViewDataSource
foreign import cloneWithRows :: forall a. ListViewDataSource -> Array a -> ListViewDataSource
foreign import textInputClass :: forall props. ReactClass props

view :: Array Props -> Array ReactElement -> ReactElement
view = createElement viewClass

viewOneChild :: Array Props -> ReactElement -> ReactElement
viewOneChild = createElementOneChild viewClass

text :: Array Props -> String -> ReactElement
text props str = createElement textClass props [textElem str]

textView :: Array Props -> Array ReactElement -> ReactElement
textView = createElement textClass

listView :: Array Props -> ReactElement
listView props = createElement listViewClass props []

touchableHighlight :: Array Props -> ReactElement -> ReactElement
touchableHighlight = createElementOneChild touchableHighlightClass

touchableNativeFeedback :: Array Props -> ReactElement -> ReactElement
touchableNativeFeedback = createElementOneChild touchableNativeFeedbackClass

textInput :: Array Props -> ReactElement
textInput props = createElement textInputClass props []
