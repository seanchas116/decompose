diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createElement = require 'virtual-dom/create-element'
h = require 'virtual-hyperscript'

module.exports =
class Component

  setData: ->

  buildTree: ->
    @children = []
    @treeCache ? @render()

  renderInner: (componentClass, data) ->

    component = new componentClass()

    component.setData(data)
    component.parent = this
    @children.push component

    component.buildTree()
