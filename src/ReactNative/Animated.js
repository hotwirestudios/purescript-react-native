'use strict';

// module ReactNative.Animated

exports.animatedViewClass = require('react-native').Animated.View;

var AnimatedValue = require('react-native').Animated.Value;
exports.animatedValue = function(param) {
    return new AnimatedValue(param);
};

var LayoutAnimation = require('react-native').LayoutAnimation;
exports.spring = function() {
    return LayoutAnimation.spring();
};
exports.linear = function() {
    return LayoutAnimation.linear();
};
exports.easeInEaseOut = function() {
    return LayoutAnimation.easeInEaseOut();
};
exports.easeIn = function() {
    return LayoutAnimation.easeIn();
};
exports.easeOut = function() {
    return LayoutAnimation.easeOut();
};
exports.keyboard = function() {
    return LayoutAnimation.keyboard();
};
