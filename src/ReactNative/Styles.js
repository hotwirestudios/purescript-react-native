'use strict';

// module ReactNative.Styles

exports.createStyleSheet = function(styles){
    var stylesObj = {};
    styles.forEach(function(s) {
        var elemStyles = s.value1;
        var elemObj = {};
        elemStyles.forEach((item) => {
            Object.keys(item).forEach((key) => {
                elemObj[key] = item[key];
            });
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

exports.mkCombinedStyleProp = function(key) {
    return function(styleId) {
        return function(styleProps) {
            return exports.unsafeMkStyleProp(key)([styleId, arrayToObject(styleProps)]);
        }
    }
};

exports.mkCombineStyleWithThisStyle = function(reactThis) {
    return function(key) {
        return function(styleId) {
            return function() {
                var style = {};
                if (reactThis.props !== undefined && reactThis.props.style !== undefined) {
                    style = reactThis.props.style;
                }
                return exports.unsafeMkStyleProp(key)([styleId, style]);
            };
        };
    };
};

exports.unsafeMkStyleProps = function(key) {
    return function(value) {
        return exports.unsafeMkStyleProp(key)(arrayToObject(value));
    }
};

var arrayToObject = function(value) {
    var result = {};
    value.forEach((item) => {
        Object.keys(item).forEach((key) => {
            result[key] = item[key];
        });
    });
    return result;
}

exports.unsafeMkStyleProp = function(key) {
    return function(value) {
        var result = {};
        result[key] = value;
        return result;
    };
};
