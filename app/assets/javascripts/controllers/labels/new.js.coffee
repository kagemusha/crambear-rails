App.LabelsNewController = Em.ObjectController.extend
  needs: ["cardSet", "cardSetsLabels"]
  startEditing: ->
    #create a new record on a local transaction
    log.log "LabelsNewController:startEditing"
    @transaction = @get('store').transaction()
    @set 'content', @transaction.createRecord(App.Label, {})

  stopEditing: ->
    #rollback the local transaction if it hasn't already been cleared
    if @transaction
      @transaction.rollback()
      @transaction = null

  save: ->
    name = @.get("content.name")
    debugger
    if Em.isEmpty(name)
      return
    if @get("controllers.cardSetsLabels.content").findProperty("name",name)
      alert("dup!")
      return
    cardSet = @get("controllers.cardSet.content")
    @content.set("cardSet", cardSet)
    @transaction.commit();
    @transaction = null;
    @startEditing()

  transitionAfterSave: ->
    log.log "trans after save"


