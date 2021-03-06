'use strict';

// module ReactNative.Props

exports.storeRef = function (reactThis) {
    return function(key) {
        return function(ref) {
            reactThis[key] = ref;
        };
    };
};

exports.getRef = function(reactThis) {
    return function (key) {
        return function () {
            return reactThis[key];
        };
    };
};

exports.getRef_ = function(reactThis) {
    return function (key) {
        return function () {
            return reactThis[key];
        };
    };
};
