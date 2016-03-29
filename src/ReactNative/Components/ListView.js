'use strict';

// module ReactNative.Components.ListView

exports.listViewClass = require('react-native').ListView;

exports.listViewDataSource = function(dict){
    return function(items){
        var ReactNative = require('react-native');
        var ListView = ReactNative.ListView;
        return new ListView.DataSource({
            rowHasChanged: function(r1, r2) { return !dict.eq(r1)(r2); }
        }).cloneWithRows(items);
    };
};

exports.listViewDataSourceWithSections = function(dict){
    return function(items){
        var ReactNative = require('react-native');
        var ListView = ReactNative.ListView;
        return new ListView.DataSource({
            rowHasChanged: function(r1, r2) { return !dict.eq(r1)(r2); },
            sectionHeaderHasChanged: function(s1, s2) { return !dict.eq(s1)(s2); }
        }).cloneWithRowsAndSections(items);
    };
};

exports.cloneWithRows = function(dataSource){
    return function(items){
        return dataSource.cloneWithRows(items);
    };
};

exports.cloneWithRowsAndSections = function(dataSource){
    return function(data){
        return dataSource.cloneWithRowsAndSections(data);
    };
};

exports.unitFn = function(data) {
    return function() {
        return data;
    };
};
