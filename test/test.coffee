assert = (require 'chai').assert
h = require 'virtual-hyperscript'
Component = require '../index'

describe 'Component', ->

  class Todo extends Component

    setData: (@todo) ->

    render: ->
      h 'li', [
        h 'h2', @todo.title
      ]

  class TodoList extends Component

    setData: (@todos) ->

    render: ->
      h 'ul', @todos.map (todo) =>
        @renderInner(Todo, todo)

  class NewTodo extends Component

    render: ->
      h 'div', [
        h 'textarea'
      ]

  class TodoApp extends Component

    setData: (@todos) ->

    render: ->
      h 'section', [
        h 'h1', 'Todo'
        @renderInner(TodoList, @todos)
        @renderInner(NewTodo)
      ]

  todos = [
    { title: 'Go to town' }
    { title: 'Buy some food' }
  ]

  describe '#buildTree', ->

    expected = h 'section', [
      h 'h1', 'Todo'
      h 'ul', [
        h 'li', [
          h 'h2', 'Go to town'
        ]
        h 'li', [
          h 'h2', 'Buy some food'
        ]
      ]
      h 'div', [
        h 'textarea'
      ]
    ]

    it 'build a virtual dom tree', ->

      app = new TodoApp()
      app.setData(todos)

      assert.deepEqual app.buildTree(), expected

    it 'returns cached tree until any descendant is updated', ->

      app = new TodoApp()
      app.setData(todos)

      assert.deepEqual app.buildTree(), expected
      assert.equal app.buildTree(), app.buildTree()

    it 'returns a new tree after any descendant is updated', ->

      app = new TodoApp()
      app.setData(todos)

      before = app.buildTree()
      app.children[0].children[0].update()
      after = app.buildTree()

      assert.deepEqual before, expected
      assert.deepEqual after, expected
      assert.notEqual before, after

  describe '#parent', ->

    it 'is the parent of the component', ->

      app = new TodoApp()
      app.setData(todos)
      app.buildTree()

      assert.equal app.children[0].parent, app

  describe '#children', ->

    it 'returns the array of the children', ->

      app = new TodoApp()
      app.setData(todos)
      app.buildTree()

      assert.equal app.children.length, 2
      assert.instanceOf app.children[0], TodoList
