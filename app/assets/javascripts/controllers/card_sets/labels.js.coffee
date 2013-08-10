App.CardSetLabelsController = Em.ArrayController.extend App.Mixins.EditState,
  needs: ["labelsNew","cardSet"]
  itemController: "label"
  saveMsg: ""
  init: ->
    @._super()
    log.log "CardSetLabelsCntrl init"

  edit: ->
    @set 'state', "editing"
    @get("controllers.labelsNew").startEditing()
  stopEditing: -> Em.K()
  cancel: (controller) ->
    controller.stopEditing() #can be either adding new or editing
    @set("state", "viewing")
