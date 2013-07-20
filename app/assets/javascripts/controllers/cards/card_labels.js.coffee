App.CardLabelsController = Em.ArrayController.extend
  needs: ["cardSet","card"]
  toggle: ->
    log.log "toggle cardLabel"