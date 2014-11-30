h = require 'virtual-hyperscript'
EventEmitter = (require 'events').EventEmitter
{Component, Mount} = require '../src/index'
DomComponent = require '../src/DomComponent'

class InputView extends DomComponent
  tag: 'input'

  onInit: ->
    @element.value = 'hoge'

class TodoCollection extends EventEmitter

  constructor: (@todos) ->

  push: (todo) ->
    @todos.push(todo)
    @emit 'update'

  shift: ->
    @todos.shift()
    @emit 'update'

class TodoView extends Component

  render: ->
    h 'li', [
      h 'h2', @todo.title
      InputView.render()
    ]

class TodoListView extends Component

  render: ->
    h 'ul', @todos.map (todo) =>
      TodoView.render todo: todo


todoCollection = new TodoCollection [
  { title: 'Go to town' }
  { title: 'Buy some food' }
]

todoListView = new TodoListView(todos: todoCollection.todos)
todoCollection.on 'update', ->
  todoListView.update()

window.addEventListener 'load', ->
  new Mount(todoListView).mount(document.getElementById('main'))
  shift = ->
    todoCollection.shift()
    todoCollection.push {title: 'New task'}
  setInterval shift, 1000
