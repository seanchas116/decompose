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
    elem.id = 'main'
    document.body.appendChild(elem)

    Todo.instances = []
    app = new TodoApp(todos: todos)
    mount = new Mount(app)

  afterEach ->
    document.body.removeChild(mount.domElement)

  describe '#mount', ->

    it 'mounts component on real dom and tracks updates', ->
      mount.mount(elem)
      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

    it 'accepts selector', ->
      mount.mount('#main')
      assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

    it 'tracks updates on inner elements', (done) ->
      mount.mount(elem)

      app.todos = todos2
      app.update()

      process.nextTick ->
        assert.deepEqual getTodosFromDOM(), ['foo', 'bar', 'baz']

        app.todos = todos
        app.update()

        process.nextTick ->
          assert.deepEqual getTodosFromDOM(), ['Go to town', 'Buy some food']

          done()

  describe '#unmount', ->

    beforeEach ->
      mount.mount(elem)

    it 'removes event listeners from component', ->
      mount.unmount()
      assert.equal app.listeners('update').length, 0

    it 'destroys all inner components', ->
      assert.equal Todo.instances.length, 2
      mount.unmount()
      assert.equal Todo.instances.length, 0
