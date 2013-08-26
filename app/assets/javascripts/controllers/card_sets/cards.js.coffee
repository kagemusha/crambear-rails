App.CardSetCardsController = Em.ArrayController.extend
  needs: ['cardSet', 'cardSetLabels',"cardsNew"]
  isShowingAddCardsButton: Em.computed.not("controllers.cardSet.isShowingNewCardsForm")
  sortProperties: ['createdAt']
  sortAscending: false
  #isEmpty: Em.computed.empty('content') #replaced w hasCards, as seemed wasn't being updated when card added
  hasCards: Em.computed.gt('content.length', 0)
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

