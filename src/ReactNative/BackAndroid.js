'use strict';

// module ReactNative.BackAndroid

var BackAndroid = require('react-native').BackAndroid;

exports.addHardwareBackPressListener = function (fn) {
    BackAndroid.addEventListener('hardwareBackPress', () => fn()());
};
