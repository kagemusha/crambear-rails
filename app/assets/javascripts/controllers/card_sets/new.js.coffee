App.CardSetsNewController = Em.ObjectController.extend
  needs: ["cardSets"]

  startEditing: ->
    @transaction = @get('store').transaction();
    #if don't set name here, get an error in stopEditing for some reason
    @set 'content', @transaction.createRecord(App.CardSet, {name: ''})

  stopEditing: ->
    if @transaction
      @transaction.rollback()

  save: ->
    @transaction.commit()
    @set("controllers.cardSets.isAddingNew", false)
    @transitionToRoute 'card_set', @get('model')

  cancel: ->
    log.log "cancel"
    @stopEditing()
    @set("controllers.cardSets.isAddingNew", false)

