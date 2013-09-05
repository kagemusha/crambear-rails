App.LabelController = Em.ObjectController.extend
  needs: ["cardSetLabels"]
  isEditing: Ember.computed.alias('controllers.cardSetLabels.isEditing')
  isDirty: Em.computed.bool('content.isDirty')

  actions:
    save: ->
      model = @get('model')
      log.log "LabelController:save: #{model.get('name')}"
      name = @.get("content.name")
      if Em.isEmpty(name)
        return
      sameNameLabels =  @get("controllers.cardSetLabels.content").filterProperty("name",name)
      #the changed label will show up in the filtered array
      #so must check if that array has length > 1 to test if dup
      if sameNameLabels.length > 1
        alert("The label '#{name}' already exists!")
        return
      @transaction = model.get('store').transaction()
      @transaction.add(model)
      @transaction.commit();
      @set 'controllers.cardSetLabels.saveMsg', "Saved '#{name}'"
      @transaction = undefined

    delete: ->
      item = @get('model')
      if (window.confirm("Are you sure you want to delete label #{@content.get('name')}?"))
        @transaction = item.get('store').transaction()
        @transaction.add(item)

        item.deleteRecord()
        @transaction.commit();


