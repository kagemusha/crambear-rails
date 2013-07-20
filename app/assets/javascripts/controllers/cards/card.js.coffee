App.CardController = Em.ObjectController.extend
  needs: ['cardSetLabels']
  isEditing: false
  toggleLabel: (val) ->
    log.log "toggleLabel: #{val}"
  #cardLbls: (-> Em.A(@get('labelIds'))).property('labelIds.@each')
  hasLabel: (id)->
    cardLbls = @get("labelIds")
    !!(cardLbls and cardLbls.indexOf(1*id) > -1)
  setLabels: (->
    log.log "setLabels updated"
    @get("controllers.cardSetLabels")
  ).property("controllers.cardSetLabels.@each","controllers.cardSetLabels.@each.name")
  #this should throw error if no .@each (or just succeed)
  cardLabels: (->
    #setLabels = @get("controllers.cardSetLabels")
    @get('setLabels').map (setLbl) =>
      id = setLbl.get("id")
      {name: setLbl.get('name'), id: id, isLabelled: @hasLabel(id)}
  ).property("controllers.cardSetLabels.@each", "labelIds.@each")
  enterEditMode: ->
    log.log "CardController:enterEditMode"
    @set "isEditing", true

    #content here seems to be the controller so need to get content.content
    #not sure why content here is the controller and not the model
    card = @get('content.content')

    log.log Ember.inspect card
    @transaction = card.get('store').transaction()
    @transaction.add card

  cancelEditMode: ->
    #cancel TX
    log.log "CardController:cancelEditMode"
    @set "isEditing", false
  save: ->
    log.log "CardController:save"
    @transaction.commit()
    @transaction = undefined
    @set 'isEditing', false
  delete: ->
    log.log "status: ", @status
    item = @get('model.content')
    if (window.confirm("Are you sure you want to delete this card?"))
      @transaction = item.get('store').transaction()
      @transaction.add(item)
      item.deleteRecord()
      @transaction.commit();

