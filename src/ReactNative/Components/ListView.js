'use strict';

// module ReactNative.Components.ListView

exports.listViewDataSource = function(dict){
    return function(items){
        var ReactNative = require('react-native');
        var ListView = ReactNative.ListView;
        return new ListView.DataSource({
            rowHasChanged: function(r1, r2) { return !dict.eq(r1)(r2); }
        }).cloneWithRows(items);
    };
};

exports.cloneWithRows = function(dataSource){
    return function(items){
        return dataSource.cloneWithRows(items);
    };
};

exports.unitFn = function(data) {
    return function() {
        return data;
    };
};
