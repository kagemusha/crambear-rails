App.CardSetLabelsController = Em.ArrayController.extend App.Mixins.EditState,
  needs: ["labelsNew","cardSet"]
  itemController: "label"
  saveMsg: "Ready"
  init: ->
    @._super()
    log.log "CardSetLabelsCntrl init"

  add: ->
    @set 'state', "adding"
    @get("controllers.labelsNew").startEditing()
  edit: ->
    @set 'state', "editing"
  saveAdd: ->
    log.log "Labels saveAdd"
    @set 'state', "viewing"
  stopEditing: -> Em.K()
  cancel: (controller) ->
    controller.stopEditing() #can be either adding new or editing
    @set("state", "viewing")
