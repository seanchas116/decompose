(function() {
  'use strict';
  var concat, findComponentNodes, flatten, isVNode, isWidget;

  isVNode = require('vtree/is-vnode');

  isWidget = require('vtree/is-widget');

  concat = Array.prototype.concat;

  flatten = function(arrays) {
    return concat.apply([], arrays);
  };

  module.exports = findComponentNodes = function(tree) {
    switch (false) {
      case !(isVNode(tree) && tree.children):
        return flatten(tree.children.map(findComponentNodes));
      case !(isWidget(tree) && tree.widgetType === 'Component'):
        return [tree];
      default:
        return [];
    }
  };

}).call(this);
