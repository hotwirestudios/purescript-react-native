'use strict';

// module ReactNative.Props.Android
var TouchableNativeFeedback = require('react-native').TouchableNativeFeedback;

exports.selectableBackground_ = function () {
    return TouchableNativeFeedback.SelectableBackground();
};

exports.selectableBackgroundBorderless_ = function () {
    return TouchableNativeFeedback.SelectableBackgroundBorderless();
};

exports.ripple_ = function (color) {
    return function (borderless) {
        return TouchableNativeFeedback.Ripple(color, borderless);
    };
};
