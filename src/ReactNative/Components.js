'use strict';

// module ReactNative.Components

exports.viewClass = require('react-native').View;
exports.textClass = require('react-native').Text;
exports.listViewClass = require('react-native').ListView;
exports.touchableHighlightClass = require('react-native').TouchableHighlight;
exports.touchableOpacityClass = require('react-native').TouchableOpacity;
exports.textInputClass = require('react-native').TextInput;

exports.listViewDataSource = function(dict){
  return function(items){
    var ReactNative = require('react-native');
    var ListView = ReactNative.ListView;
    return new ListView.DataSource({
      rowHasChanged: function(r1, r2){ return !dict.eq(r1)(r2); }
    }).cloneWithRows(items);
  }
}

exports.cloneWithRows = function(dataSource){
  return function(items){
    return dataSource.cloneWithRows(items);
  }
}

function mkProps(result) {
    return function (props) {
        for (var i = 0, len = props.length; i < len; i++) {
            var prop = props[i];
            for (var key in prop) {
                if (prop.hasOwnProperty(key)) {
                    result[key] = prop[key];
                }
            }
        }
        return result;
    }
}

function getProps(props) {
    var p = null;
    if (Array.isArray(props)) {
        if (props.length > 0) {
            p = mkProps({})(props);
        }
    } else if (props.props !== undefined && props.customProps !== undefined) {
        p = mkProps(props)(props.props);
    } else {
        p = props;
    }
    return p;
}

exports.createElement = function(clazz) {
    return function(props) {
        return function(children) {
            return React.createElement(clazz, getProps(props), children);
        }
    }
};

exports.createElementOneChild = function(clazz) {
    return function(props) {
        return function(child) {
            return React.createElement(clazz, getProps(props), child);
        }
    }
};

exports.createElementNoChild = function(clazz) {
    return function(props) {
        return React.createElement(clazz, getProps(props));
    }
};

exports.textElem = function(text) {
    return text;
};
