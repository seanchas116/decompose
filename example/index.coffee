h = require 'virtual-hyperscript'
EventEmitter = (require 'events').EventEmitter
Component = require '../src/Component'
Mount = require '../src/Mount'
DomComponent = require '../src/DomComponent'

class InputView extends DomComponent
  tag: 'input'

  onInit: ->
    @element.value = 'hoge'

class TodoCollection extends EventEmitter

  constructor: (@todos) ->

  add: (todo) ->
    @todos.push(todo)
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
  setInterval (-> todoCollection.add {title: 'New task'}), 1000
