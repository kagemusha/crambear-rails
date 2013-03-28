App.CardSetController = Em.ObjectController.extend
  needs: ["cardsNew"]
  isAddingItem: false
  isEditingName: false
  showNewForm: (->
    @get('isAddingItem') or not @get('hasCards')
  ).property('hasCards', 'isAddingItem')
  hasCards: (->
    log.log "hasCards", @get('content.cards.length')
    @get('content.cards.length') > 0
  ).property('content.cards.length')
  editName: ->
    @set 'isEditingName', true
    log.log Ember.inspect(@get('content'))
    set = @get('content')
    @transaction = set.get('store').transaction()
    @transaction.add set
  update: ->
    @transaction.commit()
    @transaction = undefined
    @set 'isEditingName', false
  addCards: ->
    @set "isAddingItem", true
    @get("controllers.cardsNew").startEditing()
  delete: ->
    log.log "CardSetController:delete>> set: #{@content.get('name')}"
    if (window.confirm("Are you sure you want to delete set #{@content.get('name')}?")) 
      @get('content').deleteRecord()
      @get('store').commit()
      @get('target.router').transitionTo('card_sets.index')
