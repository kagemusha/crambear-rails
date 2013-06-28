App.LabelsItemController = Em.ObjectController.extend
  needs: ["cardSetLabels"]
  isEditing: Ember.computed.alias('controllers.cardSetLabels.isEditing')
  delete: ->
    log.log "LabelsEditController:delete>> set: #{@content.get('name')}"
    if (window.confirm("Are you sure you want to delete label #{@content.get('name')}?"))
      @get('content').deleteRecord()
      @get('store').commit()
