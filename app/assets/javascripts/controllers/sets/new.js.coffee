App.SetsNewController = Em.ObjectController.extend
  cancel: ->
    log.log "cancel"
    #@stopEditing()
    @transitionToRoute 'sets'

