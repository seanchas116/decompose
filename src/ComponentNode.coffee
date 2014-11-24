'use strict'

Mount = require './Mount'

module.exports =
class ComponentNode

  type: 'Widget'

  constructor: (@klass, @attrs) ->
    @callback

  init: ->
    @component = new @klass()
    @component.setAttributes(@attrs)
    @mount = new Mount(@component)
    @mount.create()

  update: (old, dom) ->
    @component = old.component
    @mount = old.mount
    @component.setAttributes(@attrs)

  destroy: (dom) ->
    @mount.unmount()
    @component.destroy()
