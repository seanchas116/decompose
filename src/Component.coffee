'use strict'

h = require 'virtual-hyperscript'
assign = Object.assign ? require 'object-assign'
EventEmitter = (require 'events').EventEmitter
ComponentNode = require './ComponentNode'
findComponents = require './findComponents'

module.exports =
class Component extends EventEmitter

  constructor: (attrs) ->
    @setAttributes(attrs)
    @onInit()

  setAttributes: (attrs) ->
    assign(this, attrs)
    @emit 'update'

  destroy: ->
    if @mount?
      findComponents(@mount.tree).forEach (c)->
        c.destroy()
    @onDestroy()

  update: ->
    @emit 'update'

  render: ->
    h 'div'

  onInit: ->

  onDestroy: ->

  @render: (attrs) ->
    new ComponentNode(this, attrs ? {})
