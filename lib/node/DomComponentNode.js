(function() {
  'use strict';
  var DomComponentNode;

  module.exports = DomComponentNode = (function() {
    DomComponentNode.prototype.type = 'Widget';

    DomComponentNode.prototype.widgetType = 'DomComponent';

    function DomComponentNode(klass, attrs) {
      this.klass = klass;
      this.attrs = attrs;
    }

    DomComponentNode.prototype.init = function() {
      this.component = new this.klass(this.attrs);
      return this.component.element;
    };

    DomComponentNode.prototype.update = function(old, dom) {
      if (old.klass !== this.klass) {
        return this.init();
      }
      this.component = old.component;
      return this.component.element;
    };

    DomComponentNode.prototype.destroy = function(dom) {
      return this.component.destroy();
    };

    return DomComponentNode;

  })();

}).call(this);
