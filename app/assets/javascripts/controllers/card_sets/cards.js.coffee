App.CardSetCardsController = Em.ArrayController.extend
  needs: ['cardSet', 'cardSetLabels',"cardsNew"]
  isShowingAddCardsButton: Em.computed.not("controllers.cardSet.isShowingNewCardsForm")
  sortProperties: ['createdAt']
  sortAscending: false
  isEmpty: Em.computed.empty('content')
  labels: Em.computed.alias('controllers.cardSetLabels.content')
  itemController: 'card'

  update: ->
    @transaction.commit()
    @transaction = undefined
    @set 'isEditingName', false
  addCards: ->
    log.log "cardsetcardcontroller- add cards"
    @set "controllers.cardSet.isAddingNew", true
    @get("controllers.cardsNew").startEditing()

