EventEmitter = (require 'events').EventEmitter

module.exports =
class Component extends EventEmitter

  setData: ->

  buildTree: ->
    @children = []
    @treeCache ?= @render()
    @treeCache

  renderInner: (componentClass, data) ->

    component = new componentClass()

    component.setData(data)
    component.parent = this
    @children.push component

    component.buildTree()

  update: ->
    @treeCache = null
    @emit 'update'
    if @parent?
      @parent.update()
