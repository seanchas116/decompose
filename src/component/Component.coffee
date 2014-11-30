'use strict'

h = require 'virtual-hyperscript'
EventEmitter = (require 'events').EventEmitter
ComponentNode = require '../node/ComponentNode'

module.exports =
class Component extends EventEmitter

  constructor: (attrs) ->
    @assign(attrs)
    @onInit()

  assign: (attrs) ->
    willUpdate = false
    for own key, value of attrs
      if this[key] != value
        this[key] = value
        willUpdate = true
    @emit 'update' if willUpdate

  destroy: ->
    @onDestroy()

  update: ->
    @emit 'update'

  render: ->
    h 'div'

  onInit: ->

  onMount: ->

  onUnmount: ->

  @render: (attrs) ->
    new ComponentNode(this, attrs ? {})
