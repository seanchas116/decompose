(function() {
  'use strict';
  var ComponentNode, Mount;

  Mount = require('../mount/Mount');

  module.exports = ComponentNode = (function() {
    ComponentNode.prototype.type = 'Widget';

    ComponentNode.prototype.widgetType = 'Component';

    function ComponentNode(klass, attrs) {
      this.klass = klass;
      this.attrs = attrs;
    }

    ComponentNode.prototype.init = function() {
      this.component = new this.klass();
      this.component.assign(this.attrs);
      this.mount = new Mount(this.component);
      return this.mount.create();
    };

    ComponentNode.prototype.update = function(old, dom) {
      if (old.klass !== this.klass) {
        return this.init();
      }
      this.component = old.component;
      this.mount = old.mount;
      this.component.assign(this.attrs);
      return this.mount.dom;
    };

    ComponentNode.prototype.destroy = function() {
      return this.mount.unmount();
    };

    return ComponentNode;

  })();

}).call(this);
