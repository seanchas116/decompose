assert = (require 'chai').assert
Mount = require '../lib/Mount'
{Todo, TodoList, NewTodo, TodoApp} = require './fixtures/components'

todos = [
  { title: 'Go to town' }
  { title: 'Buy some food' }
]

describe 'Mount', ->

  app = null

  beforeEach ->
    elem = document.createElement('div')
    document.body.appendChild(elem)

    app = new TodoApp(todos: todos)
    new Mount(app).mount(elem)

  describe '.mount', ->

    it 'mounts component on real dom', ->

      assert.equal document.querySelectorAll('.todo-title').length, 2

      app.todos.push {title: 'hoge'}
      app.update()

      assert.equal document.querySelectorAll('.todo-title').length, 3
