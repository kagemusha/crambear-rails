App.NavbarController = Ember.Controller.extend
  authStateBinding: Ember.Binding.oneWay 'App.LoginStateManager.currentState'
  authState: null,
  authenticated: (->
    log.info "NavbarController authent"
    @.get("authState") == App.LoginStateManager.authenticated
  ).property("authState")
  user: (->
    if @.get("authState") == App.LoginStateManager.authenticated
      App.currentUser
    else
      null
  ).property("authState")
  greeting: (->
    name = @get("user.name")
    if Ember.isEmpty(name) then @get("user.email") else name
  ).property("user.name", "user.email")
  gravatarHash: (->
    return null if not @get("user")
    md5Hash = CryptoJS.MD5(@.get("user.email"))
    "http://www.gravatar.com/avatar/#{md5Hash}?s=40"
  ).property("user.email")
  #logout event can be captured here, but seems recommended thing is to
  #capture events in routes.  also not obvious how to change pages from controllers

  actions:
    logout: ->
      #log.info "NavbarController handling logout event..."
      me = @
      App.Authentication.logout -> me.transitionToRoute "home"
