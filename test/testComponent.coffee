'use strict'

assert = (require 'chai').assert
{Component} = require '../src/index'

describe 'Component', ->

  describe '#constructor', ->

    class Test extends Component

      onInit: ->
        @foo = @bar

    it 'calls #onInit after assigning params', ->
      test = new Test(bar: 'hoge')
      assert.equal test.foo, 'hoge'
