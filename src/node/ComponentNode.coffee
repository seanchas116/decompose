'use strict'

Mount = require '../mount/Mount'

module.exports =
class ComponentNode

  type: 'Widget'
  widgetType: 'Component'

  constructor: (@klass, @attrs) ->

  init: ->
    @component = new @klass()
    @component.assign(@attrs)
    @mount = new Mount(@component)
    @mount.create()

  update: (old, dom) ->
    if old.klass != @klass
      return @init()

    @component = old.component
    @mount = old.mount
    @component.assign(@attrs)
    @mount.dom

  destroy: () ->
    @mount.unmount()
