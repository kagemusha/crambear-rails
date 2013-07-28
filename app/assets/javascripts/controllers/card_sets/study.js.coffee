App.CardSetsStudyController = Ember.ObjectController.extend
  needs: ['cardSetLabels']
  isShowingFront: true
  correctCount: 0
  finished: false
  order: []
  cards: Em.computed.alias("content.cards")
  currentCard: null
  total: (->
    if @get("cards") then  @get("cards.length") else 0
  ).property("cards")

  #filters
  cardSetLabels: Em.computed.alias("content.labels")
  selectedFilterIds: Em.A()
  filters: (->
    log.log "updating filter ids"
    @get('labels').map (label) =>
      labelId = 1*label.get("id") #force type to number
      selected = @get('selectedFilterIds').contains(labelId)
      {name: label.get('name'), id: labelId, isSelected: selected}
  ).property("selectedFilterIds.@each")
  toggleFilter: (labelId) ->
    log.log "toggleFilter", @get("selectedFilterIds")
    labelId *= 1 #force type => number
    lbls = @get("selectedFilterIds")
    if lbls.contains(labelId)
      lbls.removeObject(labelId)
    else
      lbls.pushObject(labelId)
    log.log @get("selectedFilterIds")

  restart: ->
    #debugger
    @set "finished", false
    @set "correctCount", 0
    @initLabels
    @orderCards()
    @next()

  orderCards: ->
    log.log "orderC"
    @order = [0..@get("total")-1]
    log.log "orderLen: #{@order.length}"

  initLabels: -> Em.K()

  front: (->
    @get('currentCard.front')
  ).property('currentCard')

  back: (->
    @get('currentCard.back')
  ).property('currentCard')

  flip: ->
    log.log "action flipped"
    @set "isShowingFront", false

  correct: ->
    @set "correctCount", @get("correctCount")+1
    log.log "action correct"
    @next()

  wrong: ->
    log.log "action wrong"
    @next()

  next: ->
    @set "isShowingFront", true
    if @order.length==0
      @set "finished", true
    else
      cardId = @order.shift()
      @set "currentCard", @get("cards").objectAt(cardId)