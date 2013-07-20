App.LabelController = Em.ObjectController.extend
  needs: ["cardSetLabels"]
  isEditing: Ember.computed.alias('controllers.cardSetLabels.isEditing')
  isDirty: Em.computed.bool('content.isDirty')
  delete: ->
    item = @get('model')
    if (window.confirm("Are you sure you want to delete label #{@content.get('name')}?"))
      @transaction = item.get('store').transaction()
      @transaction.add(item)

      item.deleteRecord()
      @transaction.commit();
  startEditing: ->
    model = @get('model')
    log.log "LabelController:startEditing: #{model.get('name')}"
    @transaction = model.get('store').transaction()
    @transaction.add(model)

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
    debugger
    @transaction.commit();
    @set 'controllers.cardSetLabels.saveMsg', "Saved '#{name}'"
    @transaction = undefined;
    @startEditing()


  stopEditing: ->
    #rollback the local transaction if it hasn't already been cleared
    if @transaction
      @transaction.rollback()
      @transaction = null
  parentStateChanged: (->
    state = @get('controllers.cardSetLabels.state')
    log.log("parenStat: " + state)
    if (state=='editing')
      @startEditing()
    else if (state=='viewing')
      log.log("vieewww")
      @stopEditing()
  ).observes('controllers.cardSetLabels.state')
