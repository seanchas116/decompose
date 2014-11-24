assert = (require 'chai').assert
h = require 'virtual-hyperscript'
Component = require '../lib/Component'
Mount = require '../lib/Mount'

class Todo extends Component

  render: ->
    h 'li', [
      h 'h2.todo-title', @todo.title
    ]

class TodoList extends Component

  render: ->
    h 'ul', @todos.map (todo) =>
      Todo.render todo: todo

class NewTodo extends Component

  render: ->
    h 'div', [
      h 'textarea'
    ]

class TodoApp extends Component

  render: ->
    h 'section', [
      h 'h1', 'Todo'
      TodoList.render todos: @todos
      NewTodo.render()
    ]

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
