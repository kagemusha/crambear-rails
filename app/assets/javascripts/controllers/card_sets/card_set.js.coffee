App.CardSetController = Em.ObjectController.extend
  isAddingItem: false
  addCards: ->
    @set "isAddingItem", true
  delete: ->
    log.log "CardSetController:delete>> set: #{@content.get('name')}"
    if (window.confirm("Are you sure you want to delete set #{@content.get('name')}?")) 
      @get('content').deleteRecord()
      @get('store').commit()
      @get('target.router').transitionTo('card_sets.index')
