App.CardSetsStudyController = Ember.ObjectController.extend
  showingFront: true
  correctCount: 0
  finished: false
  order: []
  cards: null
  total: (->
    #cards =
    if @get("cards") then  @get("cards.length") else 0
  ).property("cards")
  init: -> log.log "CardSetsStudyController.init!! This gets called AUTOMATICALLY"
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
  currentCard: null
  front: (->
    @get('currentCard').get("front")
  ).property('currentCard')
  back: (->
    @get('currentCard').get("back")
  ).property('currentCard')
  flip: ->
    log.log "action flipped"
    @set "showingFront", false
  correct: ->
    @set "correctCount", @get("correctCount")+1
    log.log "action correct"
    @next()
  wrong: ->
    log.log "action wrong"
    @next()
  next: ->
    @set "showingFront", true
    if @order.length==0
      @set "finished", true
      #@render 'sets/set_actions', into: "set", outlet: "setActions"
    else
      cardId = @order.shift()
      @set "currentCard", @get("cards").objectAt(cardId)