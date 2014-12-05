(function() {
  'use strict';
  var Mount, createDom, diff, findComponentNodes, patch;

  diff = require('virtual-dom/diff');

  patch = require('virtual-dom/patch');

  createDom = require('virtual-dom/create-element');

  module.exports = Mount = (function() {
    function Mount(component) {
      this.component = component;
      this.updateCallback = (function(_this) {
        return function() {
          return _this.update();
        };
      })(this);
    }

    Mount.prototype.update = function() {
      var newTree, patches;
      newTree = this.component.render();
      patches = diff(this.tree, newTree);
      this.domElement = patch(this.domElement, patches);
      return this.tree = newTree;
    };

    Mount.prototype.mount = function(placeholder) {
      var parent, selector;
      if (typeof placeholder === 'string') {
        selector = placeholder;
        placeholder = document.querySelector(selector);
        if (placeholder == null) {
          throw new Error("No such element found: '" + selector + "'");
        }
      }
      this.create();
      parent = placeholder.parentElement;
      return parent.replaceChild(this.domElement, placeholder);
    };

    Mount.prototype.create = function() {
      this.tree = this.component.render();
      this.domElement = createDom(this.tree);
      this.component.on('update', this.updateCallback);
      this.component.onMount();
      return this.domElement;
    };

    Mount.prototype.unmount = function() {
      this.component.removeListener('update', this.updateCallback);
      findComponentNodes(this.tree).forEach(function(node) {
        return node.destroy();
      });
      return this.component.onUnmount();
    };

    return Mount;

  })();

  findComponentNodes = require('../node/findComponentNodes');

}).call(this);
