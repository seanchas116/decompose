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
    @domElement = patch(@domElement, patches)
    @tree = newTree

  mount: (placeholder) ->
    if typeof placeholder == 'string'
      selector = placeholder
      placeholder = document.querySelector(selector)
      unless placeholder?
        throw new Error("No such element found: '#{selector}'")
    @create()
    parent = placeholder.parentElement
    parent.replaceChild(@domElement, placeholder)

  create: ->
    @tree = @component.render()
    @domElement = createDom(@tree)

    @component.on 'update', @updateCallback
    @component.onMount()

    @domElement

  unmount: ->
    @component.removeListener 'update', @updateCallback

    findComponentNodes(@tree).forEach (node) ->
      node.destroy()
    @component.onUnmount()

findComponentNodes = require '../node/findComponentNodes'
