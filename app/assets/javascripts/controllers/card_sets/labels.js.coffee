App.CardSetLabelsController = Em.ArrayController.extend App.Mixins.EditState,
  needs: ["labelsNew","cardSet"]
  itemController: "label"
  saveMsg: ""
  init: ->
    @._super()
    log.log "CardSetLabelsCntrl init"

  stopEditing: -> Em.K()
  actions:
    edit: ->
      @set 'state', "editing"
      @get("controllers.labelsNew").startEditing()
    cancel: (controller) ->
      controller.stopEditing() #can be either adding new or editing
      @set("state", "viewing")
