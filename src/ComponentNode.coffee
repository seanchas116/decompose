'use strict'

Mount = require './Mount'

module.exports =
class ComponentNode

  type: 'Widget'
  widgetType: 'Component'

  constructor: (@klass, @attrs) ->

  init: ->
    @component = new @klass()
    @component.setAttributes(@attrs)
    @mount = new Mount(@component)
    @mount.create()

  update: (old, dom) ->
    if old.klass != @klass
      return @init()

    @component = old.component
    @mount = old.mount
    @component.setAttributes(@attrs)
    @mount.dom

  destroy: () ->
    @mount.unmount()
