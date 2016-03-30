'use strict';

// module ReactNative.Props.Android
var TouchableNativeFeedback = require('react-native').TouchableNativeFeedback;

exports.selectableBackground_ = function () {
    if (TouchableNativeFeedback === undefined || TouchableNativeFeedback.SelectableBackground === undefined) {
        return null;
    }
    return TouchableNativeFeedback.SelectableBackground();
};

exports.selectableBackgroundBorderless_ = function () {
    if (TouchableNativeFeedback === undefined || TouchableNativeFeedback.SelectableBackgroundBorderless === undefined) {
        return null;
    }
    return TouchableNativeFeedback.SelectableBackgroundBorderless();
};

exports.ripple_ = function (color) {
    return function (borderless) {
        if (TouchableNativeFeedback === undefined || TouchableNativeFeedback.Ripple === undefined) {
            return null;
        }
        return TouchableNativeFeedback.Ripple(color, borderless);
    };
};
