App.CardController = Em.ObjectController.extend
  needs: ['cardSetLabels']

  isEditing: false
  #gotta be better way to do all this - maybe need custom view
  isArchived: Em.computed.alias("archived")
  toggleArchived: ->
    @set("archived", !@get("archived"))
    @save()
  toggleLabel: (labelId) ->
    labelId *= 1 #force type => number
    lbls = @get("labelIds")
    if lbls.contains(labelId)
      lbls.removeObject(labelId)
    else
      lbls.pushObject(labelId)

    # labelId is of type DS.Attr 'array' which was added via
    # Adapter.registerTransform (see store.js.coffee). added
    # types don't change state, so to force rec to
    # save, must call transitionTo('updated') manually
    model = @get('content')
    model.stateManager.transitionTo('updated');
    @save()

  hasLabel: (id)->
    cardLbls = @get("labelIds")
    !!(cardLbls and cardLbls.indexOf(1*id) > -1)

  cardSetLabels: (->
    @get("controllers.cardSetLabels")
  ).property("controllers.cardSetLabels.[]","controllers.cardSetLabels.@each.name")
  #this should throw error if no .@each (or just succeed)

  cardLabels: (->
    @get('cardSetLabels').map (setLbl) =>
      id = setLbl.get("id")
      {name: setLbl.get('name'), id: id, isLabelled: @hasLabel(id)}
  ).property("controllers.cardSetLabels.@each", "labelIds.@each")

  enterEditMode: ->
    @set "isEditing", true

  cancelEditMode: ->
    @set "isEditing", false

  save: ->
    card = @get('content')
    @transaction = card.get('store').transaction()
    @transaction.add card
    @transaction.commit()
    @transaction = undefined
    @set 'isEditing', false

  delete: ->
    item = @get('model')
    if (window.confirm("Are you sure you want to delete this card?"))
      @transaction = item.get('store').transaction()
      @transaction.add(item)
      item.deleteRecord()
      @transaction.commit();
