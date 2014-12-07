(function() {
  'use strict';
  var Mount, createDom, diff, findComponentNodes, patch;

  diff = require('virtual-dom/diff');

  patch = require('virtual-dom/patch');

  createDom = require('virtual-dom/create-element');

  module.exports = Mount = (function() {
    function Mount(component) {
      this.component = component;
      this.queueCallback = (function(_this) {
        return function() {
          return _this.queue();
        };
      })(this);
      this.queued = false;
      this.domElement = null;
      this.tree = null;
    }

    Mount.prototype.update = function() {
      var newTree, patches;
      newTree = this.component.render();
      patches = diff(this.tree, newTree);
      this.domElement = patch(this.domElement, patches);
      this.tree = newTree;
      return this.queued = false;
    };

    Mount.prototype.queue = function() {
      if (!this.queued) {
        process.nextTick((function(_this) {
          return function() {
            return _this.flush();
          };
        })(this));
        return this.queued = true;
      }
    };

    Mount.prototype.flush = function() {
      if (this.queued) {
        return this.update();
      }
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
      this.component.on('update', this.queueCallback);
      this.component.onMount();
      return this.domElement;
    };

    Mount.prototype.unmount = function() {
      this.component.removeListener('update', this.queueCallback);
      findComponentNodes(this.tree).forEach(function(node) {
        return node.destroy();
      });
      return this.component.onUnmount();
    };

    return Mount;

  })();

  findComponentNodes = require('../node/findComponentNodes');

}).call(this);
