App.CardsTableRowController = Em.ObjectController.extend
  isEditing: false
  enterEditMode: ->
    log.log "CardsTableRowController:enterEditMode"
    @set "isEditing", true

    #content here seems to be the controller so need to get content.content
    #not sure why content here is the controller and not the model
    card = @get('content.content')

    log.log Ember.inspect card
    @transaction = card.get('store').transaction()
    @transaction.add card

  cancelEditMode: ->
    #cancel TX
    log.log "CardsTableRowController:cancelEditMode"
    @set "isEditing", false
  save: ->
    log.log "CardsTableRowController:save"
    @transaction.commit()
    @transaction = undefined
    @set 'isEditing', false
  deleteCard: ->
    log.log "CardsTableRowController:delete>>"
    #debugger
    item = @get('model.content')
    log.log Ember.inspect(item)
    log.log "ItemType: #{item.get("type")} Id: #{item.get("id")}"
    if (window.confirm("Are you sure you want to delete this card?"))
      log.log "front: #{@get('model.front')}"
      item.deleteRecord()
      @get('store').commit()
#      @get('target.router').transitionTo('card_sets.index')

