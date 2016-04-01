'use strict';

// module ReactNative.Components.Android

exports.touchableNativeFeedbackClass = require('react-native').TouchableNativeFeedback;
exports.viewPagerAndroidClass = require('react-native').ViewPagerAndroid;
exports.toolbarAndroidClass = require('react-native').ToolbarAndroid;
exports.progressBarAndroidClass = require('react-native').ProgressBarAndroid;

exports.setPage = function(viewPager) {
    return function (pageIndex) {
        return function () {
            viewPager.setPage(pageIndex);
        }
    }
}
