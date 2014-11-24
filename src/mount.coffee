'use strict'

diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createDom = require 'virtual-dom/create-element'

module.exports =
class Mount

  constructor: (@component) ->
    @updateCallback = => @update()

  update: ->
    newTree = @component.render()
    patches = diff(@tree, newTree)
    @dom = patch(@dom, patches)
    @tree = newTree

  mount: (placeholder) ->
    @create()
    parent = placeholder.parentElement
    parent.replaceChild(@dom, placeholder)

  create: ->
    @tree = @component.render()
    @dom = createDom(@tree)
    @component.on 'update', @updateCallback
    @dom

  unmount: ->
    @component.removeEventListener 'update', @updateCallback
