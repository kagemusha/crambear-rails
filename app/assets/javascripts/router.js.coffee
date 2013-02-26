## In a real app you will probably want to separate components into different files
## They are grouped together here for ease of exposition

#Notes
# for nested @resource @route can do #linkTo resource.route
# for nested @resource @resource, seems can't


App.Router.map ->
  @route "home"
  @route "help"
  @route "login"
  @route "registration"
  @resource 'sets', ->
    @route 'new'
    @resource 'set', { path: ':set_id' }, ->
    @route 'study', { path: ':set_id/study' }, ->


App.HomeRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'sets' if App.authenticated

App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'home'


App.SetsRoute = Ember.Route.extend
  model: -> App.Set.find()
#App.HomeRoute = Ember.Route.extend
#  events:
#    logout: -> App.logout this
App.SetRoute = Ember.Route.extend
  setupController: (controller, model) ->
    log.log "SetRoute contr setup. Set id: #{model.id}"
    controller.set 'content', model

App.SetStudyRoute = Ember.Route.extend
  model: ->  App.Set.find(params.set_id)
  setupController: (controller, model) ->
    log.log "SetsStudyRoute contr setup. Set id: #{model.id}"
    controller.set 'content', model

#App.HelpRoute = Ember.Route.extend
#  events:
#    logout: -> App.logout this


App.LoginRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  setupController: (controller, model) ->
    controller.set "errorMsg", ""
  events:
    cancel: ->
      log.info "cancelling login"
      @transitionTo 'home'
    login: ->
      log.info "Logging in..."
      App.login this

App.RegistrationRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  events:
    register: ->
      log.info "Registering..."
      App.register this
    cancel: ->
      log.info "cancelling registration"
      @transitionTo 'home'
