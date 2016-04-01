'use strict';

// module ReactNative.Components.Navigator

exports.navigatorClass = require('react-native').Navigator;

exports.sceneConfigs = function () {
    var configs = require('react-native').Navigator.SceneConfigs
    return {
        pushFromRight: configs.PushFromRight,
        floatFromRight: configs.FloatFromRight,
        floatFromLeft: configs.FloatFromLeft,
        floatFromBottom: configs.FloatFromBottom,
        floatFromBottomAndroid: configs.FloatFromBottomAndroid,
        fadeAndroid: configs.FadeAndroid,
        horizontalSwipeJump: configs.HorizontalSwipeJump,
        horizontalSwipeJumpFromRight: configs.HorizontalSwipeJumpFromRight,
        verticalUpSwipeJump: configs.VerticalUpSwipeJump,
        verticalDownSwipeJump: configs.VerticalDownSwipeJump
    };
};

exports.pushRoute = function (navigator) {
    return function (route) {
        return function() {
            navigator.push(route);
        };
    };
};

exports.replaceRoute = function (navigator) {
    return function (route) {
        return function() {
            navigator.replace(route);
        };
    };
};

exports.resetRoute = function (navigator) {
    return function (route) {
        return function() {
            navigator.resetTo(route);
        };
    };
};

exports.getCurrentRoutes = function (navigator) {
    return navigator.getCurrentRoutes();
};

exports.popRoute = function (navigator) {
    return function() {
        navigator.pop();
    };
};

exports.popToTop = function (navigator) {
    return function() {
        navigator.popToTop();
    };
};

exports.setNavigator = function (props) {
    return function (navigator) {
        return function (appearing) {
            props.value0.initialProps.push({navigator: navigator});
            props.value0.initialProps.push({appearing: appearing});
            return props;
        };
    };
};

exports.getNavigationHelper = function(reactThis) {
    return function() {
        return reactThis.props.navigationHelper;
    };
};
