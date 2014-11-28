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
    if @component.mount?
      throw new Error 'cannot remount already mounted element'
    @tree = @component.render()
    @dom = createDom(@tree)
    @component.on 'update', @updateCallback
    @component.mount = this
    @dom

  unmount: ->
    @component.removeListener 'update', @updateCallback
    @component.destroy()
    @component.mount = null
