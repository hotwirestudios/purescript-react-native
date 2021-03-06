'use strict';

// module ReactNative.Components

exports.viewClass = require('react-native').View;
exports.imageClass = require('react-native').Image;
exports.textClass = require('react-native').Text;
exports.touchableHighlightClass = require('react-native').TouchableHighlight;
exports.touchableOpacityClass = require('react-native').TouchableOpacity;
exports.touchableWithoutFeedbackClass = require('react-native').TouchableWithoutFeedback;
exports.textInputClass = require('react-native').TextInput;
exports.scrollViewClass = require('react-native').ScrollView;

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

function isComponentProps(props) {
    return props.value0 !== undefined && props.value0.initialProps !== undefined && props.value0.customProps !== undefined
}

function getProps(props) {
    var p = null;
    if (Array.isArray(props)) {
        if (props.length > 0) {
            p = mkProps({})(props);
        }
    }  else if (isComponentProps(props)) {
        var result = {value0: props.value0};
        for (let key in props) {
            if (key !== "value0") {
                result[key] = props[key];
            }
        }
        p = mkProps(result)(props.value0.initialProps);
    } else {
        p = props;
    }
    return p;
}
exports.passPropsToProps = getProps;

function createNativeElement (clazz, props, childOrChildren) {
    var p = getProps(props);
    return require('react-native').createElement(clazz, p, childOrChildren);
}

exports.createNativeElement = function(clazz) {
    return function(props) {
        return function(children) {
            if (children.length === 1) {
                return createNativeElement(clazz, props, children[0]);
            } else if (children.length === 0) {
                return createNativeElement(clazz, props);
            }
            return createNativeElement(clazz, props, children);
        }
    }
};

function fixProps(element, props) {
    if (props.value0 !== undefined && props.value0.props !== undefined) {
        props.value0.props = function () {
            return element.props;
        }
    }
}

function createNativeClass(spec) {
    var result = {
        displayName: spec.displayName,
        render: function(){
            return spec.render(this)();
        },
        getInitialState: function(){
            return {
                state: spec.getInitialState(this)()
            };
        },
        componentWillMount: function(){
            fixProps(this, this.props);
            return spec.componentWillMount(this)();
        },
        componentDidMount: function(){
            return spec.componentDidMount(this)();
        },
        componentWillReceiveProps: function(nextProps){
            fixProps(this, nextProps);
            return spec.componentWillReceiveProps(this)(nextProps)();
        },
        shouldComponentUpdate: function(nextProps, nextState){
            return spec.shouldComponentUpdate(this)(nextProps)(nextState.state)();
        },
        componentWillUpdate: function(nextProps, nextState){
            return spec.componentWillUpdate(this)(nextProps)(nextState.state)();
        },
        componentDidUpdate: function(prevProps, prevState){
            return spec.componentDidUpdate(this)(prevProps)(prevState.state)();
        },
        componentWillUnmount: function(){
            return spec.componentWillUnmount(this)();
        }
    };

    return require('react-native').createClass(result);
}
exports.createNativeClass = createNativeClass;

exports.unsafeThrowPropsNotInitializedException = function() {
    throw "Pass the ComponentProps to a createNativeElement call. Afterwards the props will be available. Before that, use initialProps or customProps to access your props values.";
};

exports.textElem = function(text) {
    return text;
};

exports.focus = function(element) {
    return function() {
        element.focus();
    };
};

exports.showAlert = function(title) {
    return function(text) {
        return function(buttons) {
            return function() {
                for (let i = 0; i < buttons.length; i++) {
                    let button = buttons[i];
                    if (button.style === null) {
                        button.style = undefined;
                    }
                }
                require('react-native').Alert.alert(title, text, buttons);
            };
        };
    };
};
