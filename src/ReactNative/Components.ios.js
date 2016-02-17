'use strict';

// module ReactNative.Components.IOS

exports.tabBarIOSClass = require('react-native').TabBarIOS;
exports.tabBarItemIOSClass = require('react-native').TabBarIOS.Item;
exports.navigatorIOSClass = require('react-native').NavigatorIOS;

exports.setStatusBarStyleIOSImpl = function (style) {
    return function() {
        return require('react-native').StatusBarIOS.setStyle(style);
    }
}
