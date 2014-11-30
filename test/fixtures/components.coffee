h = require 'virtual-hyperscript'
Component = require '../../src/Component'
_ = require 'lodash'

class Todo extends Component

  @instances: []

  onMount: ->
    Todo.instances.push(this)

  render: ->
    h 'li', [
      h 'h2.todo-title', @todo.title
    ]

  onUnmount: ->
    Todo.instances.splice(Todo.instances.indexOf(this), 1)

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

module.exports = {Todo, TodoList, NewTodo, TodoApp}
