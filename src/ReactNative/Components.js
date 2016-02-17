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
    }  else if (props.value0 !== undefined && props.value0.props !== undefined && props.value0.customProps !== undefined) {
        var result = {value0: props.value0};
        p = mkProps(result)(props.value0.props);
    } else {
        p = props;
    }
    return p;
}

function createNativeElement (clazz, props, childOrChildren) {
    var p = getProps(props);
    var element = React.createElement(clazz, p, childOrChildren);
    if (p.value0 !== undefined && p.value0.standardProps !== undefined) {
        p.value0.standardProps = function () {
            return element.props;
        }
    }
    return element;
}

exports.createNativeElement = function(clazz) {
    return function(props) {
        return function(children) {
            if (children.length == 1) {
                return createNativeElement(clazz, props, children[0]);
            }
            return createNativeElement(clazz, props, children);
        }
    }
};

exports.textElem = function(text) {
    return text;
};
