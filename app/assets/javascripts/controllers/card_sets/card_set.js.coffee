App.CardSetController = Em.ObjectController.extend
  needs: ["cardSetCards","cardsNew"]
  isAddingNew: false
  isEditingName: false
  isEmpty: Em.computed.lt("cards.length",1)
  isShowingNewCardsForm: Em.computed.or("isEmpty", "isAddingNew" )
  editName: ->
    @set 'isEditingName', true
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
    if (window.confirm("Are you sure you want to delete set #{@content.get('name')}?"))

      #make sure the record deleted before retrieve recs from server
      #try this w/out run loop to see why needed
      Ember.run =>
        @get('content').deleteRecord()
        @get('store').commit()
      sets = App.CardSet.find()
      if sets.length == 0
        @get('target.router').transitionTo 'card_sets.index'
      else
        @transitionToRoute 'card_set' , sets.objectAt(0)
