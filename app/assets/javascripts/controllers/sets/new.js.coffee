App.SetsNewController = Em.ObjectController.extend

  startEditing: ->
    #create a new record on a local transaction
    @transaction = @get('store').transaction();
    @set 'content', @transaction.createRecord(App.Set, {})

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
    @transitionToRoute 'sets'  #TODO

  cancel: ->
    log.log "cancel"
    @stopEditing()
    @transitionToRoute 'sets'

