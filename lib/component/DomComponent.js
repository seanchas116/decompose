(function() {
  'use strict';
  var Component, DomComponent, DomComponentNode,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Component = require('./Component');

  DomComponentNode = require('../node/DomComponentNode');


  /*
  DomComponent provides representation for components which hold and manage a real DOM element.
   */

  module.exports = DomComponent = (function(_super) {
    __extends(DomComponent, _super);

    DomComponent.prototype.tag = 'div';

    function DomComponent(attrs) {
      this.element = document.createElement(this.tag);
      DomComponent.__super__.constructor.call(this, attrs);
    }

    DomComponent.render = function(attrs) {
      return new DomComponentNode(this, attrs != null ? attrs : {});
    };

    return DomComponent;

  })(Component);

}).call(this);
