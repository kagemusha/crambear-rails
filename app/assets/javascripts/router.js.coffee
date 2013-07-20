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



App.IndexRoute = Em.Route.extend
  beforeModel: ->
    if App.authenticated
      @transitionTo 'card_sets'
    else
      @transitionTo 'home'


App.CardSetsRoute = Em.Route.extend
  beforeModel: -> log.log "CardSetsRoute: beforeModel"

  model: ->
    #is the authentication check here cheesy, and seems for state managers
    #must refer to them directly instead of w get?  seems inconsistent
      log.log "CardSetsRoute: find card sets"
      if App.LoginStateManager.isAuthenticated()
        App.CardSet.find()
      else
        Em.A()

  afterModel: (cardSets, transition) ->
    log.log "CardSetsRoute aftermodel: trans to card set"
    if (cardSets.length > 0)
      @transitionTo 'card_set', cardSets[0]


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
    @controllerFor('cardSetCards').set('content', model.get('cards'))
    @controllerFor('cardSetLabels').set('content', model.get('labels'))

App.CardSetsStudyRoute = Em.Route.extend
  model: (params) ->  App.CardSet.find(params?.set_id)
  setupController: (controller, model) ->
    log.log "StudyRoute.setupController. Set: #{model.get("name")}"
    log.log "Card count #{model.get("cards")?.get("length")}"
    controller.set 'content', model

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
