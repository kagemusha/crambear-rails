App.CardSetController = Em.ObjectController.extend
  isAddingItem: false
  addCards: ->
    @set "isAddingItem", true