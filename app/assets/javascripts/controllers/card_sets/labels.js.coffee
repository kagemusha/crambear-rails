App.CardSetsLabelsController = Em.ObjectController.extend
  needs: ["labelsNew","cardSet"]
  state: "viewing"
  isViewing: (-> @state=="viewing").property("state")
  isAdding: (-> @state=="adding").property("state")
  isEditing: (-> @state=="editing").property("state")
  #content: Em.computed.alias('controllers.cardSet.content.labels')
  add: ->
    @set 'state', "adding"
    @get("controllers.labelsNew").startEditing()
  edit: -> @set 'state', "editing"
  cancel: -> @set 'state', "viewing"
  saveAdd: ->
    @set 'state', "viewing"
  saveEdit: ->
    @set 'state', "viewing"
  stateRep: (-> log.log "state changed to: #{@state} ").observes("state")
  cancel: (controller) ->
    controller.stopEditing() #can be either adding new or editing
    @set("state", "viewing")
