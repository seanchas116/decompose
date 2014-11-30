'use strict'

h = require 'virtual-hyperscript'
EventEmitter = (require 'events').EventEmitter
ComponentNode = require './ComponentNode'

module.exports =
class Component extends EventEmitter

  constructor: (attrs) ->
    @setAttributes(attrs)

  setAttributes: (attrs) ->
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

  onMount: ->

  onUnmount: ->

  @render: (attrs) ->
    new ComponentNode(this, attrs ? {})
