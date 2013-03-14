App.CardsNewController = Em.ObjectController.extend
  needs: ["cardSet"]
  startEditing: ->
    #create a new record on a local transaction
    @transaction = @get('store').transaction();
    @set 'content', @transaction.createRecord(App.Card, {})

  stopEditing: ->
    #rollback the local transaction if it hasn't already been cleared
    if @transaction
      @transaction.rollback()
      @transaction = null

  save: ->
    log.log "save"
    @transaction.commit();
    @transaction = null;

  transitionAfterSave: ->
    log.log "trans after save"
    #hide addCard

  cancel: ->
    log.log "cancel"
    @stopEditing()
    @set "controllers.cardSet.isAddingItem", false
    #hide addCard

