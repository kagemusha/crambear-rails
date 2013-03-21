App.CardSetController = Em.ObjectController.extend
  needs: ["cardsNew"]
  isAddingItem: false
  showNewForm: (->
    @get('isAddingItem') or not @get('hasCards')
  ).property('hasCards', 'isAddingItem')
  hasCards: (->
    log.log "hasCards", @get('content.cards.length')
    @get('content.cards.length') > 0
  ).property('content')
  addCards: ->
    @set "isAddingItem", true
    @get("controllers.cardsNew").startEditing()
  delete: ->
    log.log "CardSetController:delete>> set: #{@content.get('name')}"
    if (window.confirm("Are you sure you want to delete set #{@content.get('name')}?")) 
      @get('content').deleteRecord()
      @get('store').commit()
      @get('target.router').transitionTo('card_sets.index')
