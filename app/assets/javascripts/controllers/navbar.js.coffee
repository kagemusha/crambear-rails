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
    #log.info "NavbarController handling logout event..."
    me = @
    App.Authentication.logout -> me.transitionToRoute "home"
