diff = require 'virtual-dom/diff'
patch = require 'virtual-dom/patch'
createElement = require 'virtual-dom/create-element'

module.exports =
mount = (component, target) ->

  if typeof target == 'string'
    query = target
    target = document.querySelector(query)
    unless target?
      throw new Error("cannt find element: '#{query}'")

  tree = component.buildTree()
  element = createElement(tree)
  target.parentElement.replaceChild(element, target)

  component.on 'update', ->
    newTree = component.buildTree()
    patches = diff(tree, newTree)
    element = patch(element, patches)
    tree = newTree
