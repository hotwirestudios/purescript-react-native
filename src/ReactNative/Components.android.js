'use strict';

// module ReactNative.Components.Android

exports.touchableNativeFeedbackClass = require('react-native').TouchableNativeFeedback;
exports.viewPagerAndroidClass = require('react-native').ViewPagerAndroid;

exports.setPage = function(viewPager) {
    return function (pageIndex) {
        viewPager.setPage(pageIndex);
    }
}
