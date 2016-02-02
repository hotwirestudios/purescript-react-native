'use strict';

// module ReactNative.Styles

exports.createStyleSheet = function(styles){
  var stylesObj = {};
  styles.forEach(function(s) { 
    var elemStyles = s.value1;
    var elemObj = {};
    elemStyles.forEach((item) =>{ 
      for (const key of Object.keys(item)) {
        elemObj[key] = item[key];
      }
    });
    stylesObj[s.value0] = elemObj;
  });
  return require('react-native').StyleSheet.create(stylesObj);
}

exports.getStyleId = function(styleSheet){
  return function(key){
    return styleSheet[key];
  }
}

exports.unsafeMkStyleProps = function(key) {
  return function(value){
    var result = {};
    value.forEach((item) => {
      for (const key of Object.keys(item)) {
        result[key] = item[key];
      }
    });
    return result;
  };
};

exports.unsafeMkStyleProp = function(key) {
    return function(value) {
      var result = {};
      result[key] = value;
      return result;
    };
};