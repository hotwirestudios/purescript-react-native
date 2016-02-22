'use strict';

// module ReactNative

exports.registerComponent = function(name){
    return function(component){
        return function(){
            require('react-native').AppRegistry.registerComponent(name, function(){ return component; });
        };
    };
};

exports.platformOS = require('react-native').Platform.OS;
