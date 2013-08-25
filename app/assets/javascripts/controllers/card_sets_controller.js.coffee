App.CardSetsController = Em.ArrayController.extend
  needs: ["cardSetsNew"]
  showSidebar: true
  sortProperties: ['name']
  isAddingNew: false
  showAddSetButton: Em.computed.not("isAddingNew")
  addSet: ->
    @set "isAddingNew", true
    @get("controllers.cardSetsNew").startEditing()

