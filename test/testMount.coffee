_ = require 'lodash'
assert = (require 'chai').assert
{Mount} = require '../src/index'
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
  mount = null
  elem = null
  getTodosFromDOM = -> _.pluck(document.querySelectorAll('.todo-title'), 'innerText')

  beforeEach ->
    elem = document.createElement('div')
    document.body.appendChild(elem)

    Todo.instances = []
    app = new TodoApp(todos: todos)
    mount = new Mount(app)
    mount.mount(elem)

  afterEach ->
    document.body.removeChild(mount.domElement)

  describe '#mount', ->

    it 'mounts component on real dom and tracks updates', ->
      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

    it 'tracks updates on inner elements', ->
      app.todos = todos2
      app.update()
      assert.deepEqual getTodosFromDOM(), ['foo', 'bar', 'baz']

      app.todos = todos
      app.update()
      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

  describe '#unmount', ->

    it 'removes event listeners from component', ->
      mount.unmount()
      assert.equal app.listeners('update').length, 0

    it 'destroys all inner components', ->
      assert.equal Todo.instances.length, 2
      mount.unmount()
      assert.equal Todo.instances.length, 0
