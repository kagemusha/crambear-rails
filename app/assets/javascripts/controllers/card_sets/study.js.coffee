App.CardSetsStudyController = Ember.ObjectController.extend
  isShowingFront: true
  correctCount: 0
  finished: false
  order: []
  cards: null
  currentCard: null

  total: (->
    if @get("cards") then  @get("cards.length") else 0
  ).property("cards")

  start: (cards) ->
    @set "cards", cards
    @restart()

  restart: ->
    @set "finished", false
    @set "correctCount", 0
    @orderCards()
    @next()

  orderCards: ->
    log.log "orderC"
    @order = [0..@get("total")-1]
    log.log "orderLen: #{@order.length}"

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