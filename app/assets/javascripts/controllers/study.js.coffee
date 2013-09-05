App.StudyController = Ember.ObjectController.extend
  needs: ['cardSetLabels']
  cards: Em.computed.alias("content.cards")
  cardSetName: Em.computed.alias("content.name")
  front: Em.computed.alias("currentCard.front")
  back: Em.computed.alias("currentCard.back")
  pageRendered: true
  isShowingArchived: false
  isShowingFront: true
  isShowingBack: (-> @get("pageRendered") and not @get("isShowingFront")
  ).property("isShowingFront", "pageRendered")
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
    filteredCardIds = _.shuffle filteredCardIds
    @set("order", filteredCardIds)
    @set("filteredTotal", @order.length)
    @set("cardsLeft", @order.length)
    log.log "order: #{@order}"

  inFilter: (card)->

    #filter out archived unless isShowingArchived
    return false if (card.get("archived") and not @get("isShowingArchived") )

    #if no filters, show everything
    return true if @get("selectedFilterIds.length") == 0

    #since here are filters, filter out card if it doesn't have any labels
    cardLabels = card.get("labelIds")
    return false unless cardLabels and cardLabels.get("length") > 0

    selectedFilters = @get('selectedFilterIds')
    includedLabel = selectedFilters.find( (labelId)->
      #show card if has a label of selected filters
      cardLabels.contains(1*labelId)
    )
    !!(includedLabel?)

  initLabels: -> Em.K()

  next: ->
    @set "isShowingFront", true
    if @order.length==0
      @set "finished", true
    else
      cardId = @order.shift()
      @set "currentCard", @get("cards").objectAt(cardId)
      @set("cardsLeft", @order.length+1)

  actions:
    correct: ->
      @set "correctCount", @get("correctCount")+1
      log.log "action correct"
      @next()

    wrong: ->
      log.log "action wrong"
      @next()

    flip: ->
      log.log "action flipped"
      @set "isShowingFront", false

    toggleArchived: ->
      log.log "togArch"
      @set("isShowingArchived", !@get("isShowingArchived"))
      @restart()

    toggleFilter: (labelId) ->
      labelId *= 1 #force type => number
      lbls = @get("selectedFilterIds")
      if lbls.contains(labelId)
        lbls.removeObject(labelId)
      else
        lbls.pushObject(labelId)
      @restart()
