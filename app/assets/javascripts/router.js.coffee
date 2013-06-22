## At some point want to move routes to own file
## They are grouped together here for ease of exposition

#Notes
# for nested @resource @route can do #linkTo resource.route
# for nested @resource @resource, seems can't


App.Router.map ->
  @route "home"
  @route "help"
  @route "login"
  @route "registration"
  @resource 'card_sets', ->
    @route 'new'
    @resource 'card_set', { path: ':card_set_id' }
    @route 'study', { path: ':card_set_id/study' }


App.HomeRoute = Em.Route.extend
  redirect: ->
    @transitionTo 'card_sets' if App.authenticated

App.IndexRoute = Em.Route.extend
  redirect: ->
    @transitionTo 'home'


App.CardSetsRoute = Em.Route.extend
  model: ->
    #debugger
    #is the authentication check here cheesy, and seems for state managers
    #must refer to them directly instead of w get?  seems inconsistent
    authenticated = App.LoginStateManager.isAuthenticated()

    if authenticated then App.CardSet.find() else []

App.CardSetsNewRoute = Em.Route.extend

  #Because we are maintaining a transaction locally in the controller for editing,
  #the new record needs to be created in the controller.
  model: -> null

  setupController: (controller) ->
    log.log "CardSetsNewRoute: setupController"
    controller.startEditing()

  deactivate: ->
    @controllerFor('card_sets.new').stopEditing()
  events:
    setCreated: (cardSet) ->
      log.log "setCreated", cardSet.get('name')
      @transitionTo 'card_set', cardSet




App.CardSetRoute = Em.Route.extend
  model: (params) -> App.CardSet.find(params?.card_set_id)
  setupController: (controller, model) ->
    log.log "CardSetRoute.setupController. CardSet: #{model.get("name")} has #{model.get("cards.length")} cards"
    controller.set 'content', model
    controller.set 'isEditingName', false
    controller.addCards() if model.get("cards.length")==0 #show new card form if no cards
    @controllerFor('cardSetsLabels').set('content', model.get('labels'))


App.CardSetsStudyRoute = Em.Route.extend
  model: (params) ->  App.CardSet.find(params?.set_id)
  setupController: (controller, model) ->
    log.log "StudyRoute.setupController. Set: #{model.get("name")}"
    log.log "Card count #{model.get("cards")?.get("length")}"
    controller.set 'content', model
    controller.start model.get("cards")

#    controller.set "currentCard", model.get("cards").objectAt(0)
#    log.log "card front: #{controller.get("currentCard").get("front")}"
#    log.log "card back: #{controller.get("currentCard").get("back")}"
    #controller.set 'content', set.get('cards')


#App.HelpRoute = Em.Route.extend
#  events:
#    logout: -> App.Authentication.logout this


App.LoginRoute = Em.Route.extend
  model: (params) -> Em.Object.create()
  setupController: (controller, model) ->
    controller.set "errorMsg", ""
  events:
    cancel: ->
      log.info "cancelling login"
      @transitionTo 'home'
    login: ->
      log.info "Logging in..."
      App.Authentication.login this

App.RegistrationRoute = Em.Route.extend
  model: (params) -> Em.Object.create()
  events:
    register: ->
      log.info "Registering..."
      App.Authentication.register this
    cancel: ->
      log.info "cancelling registration"
      @transitionTo 'home'
