'use strict'

Component = require './Component'
DomComponentNode = require './DomComponentNode'

###
DomComponent provides representation for components which hold and manage a real DOM element.
###
module.exports =
class DomComponent extends Component
  tag: 'div'

  constructor: (attrs) ->
    @element = document.createElement(@tag)
    super(attrs)

  @render: (attrs) ->
    new DomComponentNode(this, attrs ? {})
