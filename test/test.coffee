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

  describe '#buildTree', ->

    it 'build a virtual dom tree', ->

      todos = [
        { title: 'Go to town' }
        { title: 'Buy some food' }
      ]

      app = new TodoApp()
      app.setData(todos)

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

      assert.deepEqual app.buildTree(), expected
