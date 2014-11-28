isVNode = require 'vtree/is-vnode'
isWidget = require 'vtree/is-widget'
ComponentNode = require './ComponentNode'

concat = Array.prototype.concat
flatten = (arrays) -> concat.apply([], arrays)

module.exports =
findComponents = (tree) ->

  switch
    when isVNode(tree) && tree.children
      flatten(tree.children.map(findComponents))
    when isWidget(tree) && tree instanceof ComponentNode
      [tree.component]
    else
      []
