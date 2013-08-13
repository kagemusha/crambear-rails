App.CardSetsStudyController = Ember.ObjectController.extend
  needs: ['cardSetLabels']
  cards: Em.computed.alias("content.cards")
  cardSetName: Em.computed.alias("content.name")
  pageRendered: true
  isShowingArchived: false
  isShowingFront: false
  isShowingBack: (-> @get("pageRendered") and not @get("isShowingFront")
  ).property("isShowingFront", "pageRendered")
  toggleArchived: ->
    log.log "togArch"
    @set("isShowingArchived", !@get("isShowingArchived"))
    @restart()
  correctCount: 0
  cardsLeft: 0
  finished: false
  currentCard: null
  order: []
  filteredTotal: cards: Em.computed.alias("order.length")
  total: (->
    if @get("cards") then  @get("cards.length") else 0
  ).property("cards")
  statusMsg: (->
    "#{@get('cardsLeft')} of #{@get('filteredTotal')} left"
  ).property("cardsLeft", "filteredTotal")

 #filtering
  cardSetLabels: Em.computed.alias("content.labels")
  selectedFilterIds: Em.A()
  filters: (->
    @get('labels').map (label) =>
      labelId = 1*label.get("id") #force type to number
      selected = @get('selectedFilterIds').contains(labelId)
      {name: label.get('name'), id: labelId, isSelected: selected}
  ).property("selectedFilterIds.@each")
  toggleFilter: (labelId) ->
    labelId *= 1 #force type => number
    lbls = @get("selectedFilterIds")
    if lbls.contains(labelId)
      lbls.removeObject(labelId)
    else
      lbls.pushObject(labelId)
    @restart()

  restart: ->
    @set "finished", false
    @set "correctCount", 0
    @initLabels
    @orderCards()
    @next()
    @set("pageRendered", true)

  orderCards: ->
    cardPositions = [0..@get("total")-1]
    cards = @get("cards")
    filteredCardIds = for i in cardPositions when @inFilter(cards.objectAt(i))
      i
    @set("order", filteredCardIds)
    @set("filteredTotal", @order.length)
    @set("cardsLeft", @order.length)
    log.log "order: #{@order}"

  inFilter: (card)->
    #filter out archived unless isShowingArchived is true
    return false if (card.get("archived") and not @get("isShowingArchived") )

    #if no filters, show everything
    return true if @get("selectedFilterIds.length") == 0

    cardLabels = card.get("labelIds")
    #since here are filters, filter out if card doesn't have any labels
    return false unless cardLabels and cardLabels.get("length") > 0

    selectedFilters = @get('selectedFilterIds')

    includedLabel = selectedFilters.find( (labelId)->
      #show card if has a label of selected filters
      cardLabels.contains(1*labelId)
    )
    !!(includedLabel?)

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
      @set("cardsLeft", @order.length+1)
