decompose
=========

[![Build Status](https://travis-ci.org/seanchas116/decompose.svg)](https://travis-ci.org/seanchas116/decompose)

decompose is a library that provides a simple component system on [virtual-dom](https://github.com/Matt-Esch/virtual-dom/)

### Features

* Class-based component system like React
  * Override `#render` to define view

* Creates and diffs virtual DOM tree and apply patches to a real DOM locally in each component
  * Using virtual-dom's "Widget" node

* Supports mixing real DOM based components

Example
--------

```coffeescript
class TodoCollection extends EventEmitter

  constructor: (@todos) ->

  add: (todo) ->
    @todos.push(todo)
    @emit 'update'

class TodoView extends Component

  render: ->
    h 'li', [
      h 'h2', @todo.title
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
```
Todo
--------

* More tests
* Better support for ES5
* Release
