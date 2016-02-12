'use strict';

// module ReactNative.Animated

exports.animatedViewClass = require('react-native').Animated.View;

var AnimatedValue = require('react-native').Animated.Value;
exports.animatedValue = function(param) {
    return new AnimatedValue(param);
};
