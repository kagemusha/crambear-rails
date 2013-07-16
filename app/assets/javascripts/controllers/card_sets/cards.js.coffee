App.CardSetCardsController = Em.ArrayController.extend
  needs: ['cardSet', 'cardSetLabels']
  labels: Em.computed.alias('controllers.cardSetLabels.content')
  itemController: 'card'
  isAddingNew: false

#  state: "viewing"
#  isViewing: (-> @get('state')=="viewing").property("state")
#  isAdding: (-> @get('state')=="adding").property("state")
#  isEditing: Em.computed.equal('state', 'editing')
#  add: ->
#    @set 'state', "adding"
#    @get("controllers.cardsNew").startEditing()
#  edit: ->
#    @set 'state', "editing"
#  cancel: -> @set 'state', "viewing"
#  saveAdd: ->
#    @set 'state', "viewing"
#  stopEditing: -> Em.K()
#  cancel: (controller) ->
#    controller.stopEditing() #can be either adding new or editing
#    @set("state", "viewing")
