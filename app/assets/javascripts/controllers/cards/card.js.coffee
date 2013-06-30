App.CardController = Em.ObjectController.extend
  isEditing: false
  enterEditMode: ->
    log.log "CardController:enterEditMode"
    @set "isEditing", true

    #content here seems to be the controller so need to get content.content
    #not sure why content here is the controller and not the model
    card = @get('content.content')

    log.log Ember.inspect card
    @transaction = card.get('store').transaction()
    debugger
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
  deleteCard: ->
    log.log "CardController:delete>>"
    item = @get('model.content')
    log.log Ember.inspect(item)
    log.log "ItemType: #{item.get("type")} Id: #{item.get("id")}"
    if (window.confirm("Are you sure you want to delete this card?"))
      log.log "front: #{@get('model.front')}"
      item.deleteRecord()
      @get('store').commit()
#      @get('target.router').transitionTo('card_sets.index')

