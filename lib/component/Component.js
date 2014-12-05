(function() {
  'use strict';
  var Component, ComponentNode, EventEmitter, h,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  h = require('virtual-hyperscript');

  EventEmitter = (require('events')).EventEmitter;

  ComponentNode = require('../node/ComponentNode');

  module.exports = Component = (function(_super) {
    __extends(Component, _super);

    function Component(attrs) {
      this.assign(attrs);
      this.onInit();
    }

    Component.prototype.assign = function(attrs) {
      var key, value, willUpdate;
      willUpdate = false;
      for (key in attrs) {
        if (!__hasProp.call(attrs, key)) continue;
        value = attrs[key];
        if (this[key] !== value) {
          this[key] = value;
          willUpdate = true;
        }
      }
      if (willUpdate) {
        return this.emit('update');
      }
    };

    Component.prototype.destroy = function() {
      return this.onDestroy();
    };

    Component.prototype.update = function() {
      return this.emit('update');
    };

    Component.prototype.render = function() {
      return h('div');
    };

    Component.prototype.onInit = function() {};

    Component.prototype.onMount = function() {};

    Component.prototype.onUnmount = function() {};

    Component.render = function(attrs) {
      return new ComponentNode(this, attrs != null ? attrs : {});
    };

    return Component;

  })(EventEmitter);

}).call(this);
