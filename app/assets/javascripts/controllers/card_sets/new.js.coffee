App.CardSetsNewController = Em.ObjectController.extend
  needs: ["cardSets","cardSet"]

  startEditing: ->
    @transaction = @get('store').transaction();
    #if don't set name here, get an error in stopEditing for some reason
    @set 'content', @transaction.createRecord(App.CardSet, {name: ''})

  stopEditing: ->
    if @transaction
      @transaction.rollback()

  actions:
    save: ->
      @transaction.commit()
      @set("controllers.cardSets.isAddingNew", false)
      @set("controllers.cardSet.isAddingNew", true)
      @transitionToRoute 'card_set', @get('model')

    cancel: ->
      log.log "cancel"
      @stopEditing()
      @set("controllers.cardSets.isAddingNew", false)

