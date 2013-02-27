## In a real app you will probably want to separate components into different files
## They are grouped together here for ease of exposition

App.NavbarController = Ember.ObjectController.extend
  authStateBinding: Ember.Binding.oneWay 'App.LoginStateManager.currentState'
  authState: null,
  authenticated: (->
    log.info "NavbarController authent"
    @.get("authState") == App.LoginStateManager.authenticated
  ).property("authState")
  #logout event can be captured here, but seems recommended thing is to
  #capture events in routes.  also not obvious how to change pages from controllers
  logout: ->
    log.info "NavbarController handling logout event..."
    me = @
    App.logout -> me.transitionToRoute "home"


App.WelcomeMsgController = Ember.ObjectController.extend
  authStateBinding: Ember.Binding.oneWay 'App.LoginStateManager.currentState'
  authState: null,
  user: (->
    if @.get("authState") == App.LoginStateManager.authenticated
      App.currentUser
    else
      null
  ).property("authState")

#App.SetController = Ember.ObjectController.extend {}


App.SetsStudyController = Ember.ObjectController.extend
  showingFront: true
  order: []
  cards: null
  init: -> log.log "SetsStudyController.init!! This gets called AUTOMATICALLY"
  start: (cards) ->
    @cards = cards
    @orderCards()
    @next()
  orderCards: ->
    log.log "orderC"
    @order = [0..@get("cards").get("length")-1]
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
    log.log "action correct"
    @next()
  wrong: ->
    log.log "action wrong"
    @next()
  next: ->
    @set "showingFront", true
    if @order.length==0
      #@render 'sets/set_actions', into: "set", outlet: "setActions"
    else
      cardId = @order.shift()
      @set "currentCard", @get("cards").objectAt(cardId)