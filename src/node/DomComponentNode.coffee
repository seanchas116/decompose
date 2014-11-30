'use strict'

module.exports =
class DomComponentNode

  type: 'Widget'
  widgetType: 'DomComponent'

  constructor: (@klass, @attrs) ->

  init: ->
    @component = new @klass(@attrs)
    @component.element

  update: (old, dom) ->
    if old.klass != @klass
      return @init()

    @component = old.component
    @component.element

  destroy: (dom) ->
    @component.destroy()
