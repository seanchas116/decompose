_ = require 'lodash'
assert = (require 'chai').assert
Mount = require '../src/Mount'
{Todo, TodoList, NewTodo, TodoApp} = require './fixtures/components'

todos = [
  { title: 'Go to town' }
  { title: 'Buy some food' }
]

todos2 = [
  { title: 'foo' }
  { title: 'bar' }
  { title: 'baz' }
]

describe 'Mount', ->

  app = null

  beforeEach ->
    elem = document.createElement('div')
    document.body.appendChild(elem)

    app = new TodoApp(todos: todos)
    new Mount(app).mount(elem)

  describe '#mount', ->

    it 'mounts component on real dom and tracks updates', ->

      getTodosFromDOM = -> _.pluck(document.querySelectorAll('.todo-title'), 'innerText')

      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

      app.todos = todos2
      app.update()

      assert.deepEqual getTodosFromDOM(), ['foo', 'bar', 'baz']

      app.todos = todos
      app.update()

      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']
