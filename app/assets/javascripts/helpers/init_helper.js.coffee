App.initApp = (currentUser) ->
  log.log "initApp"
  initHelperMethods()
  App.initCurrentUser currentUser
  App.LoginStateManager.transitionTo 'authenticated' if App.currentUser


App.initCurrentUser = (currentUser) ->
  log.info "current user: ", currentUser
  App.currentUser =  currentUser if currentUser?.email


initHelperMethods = ->
  App.authenticated = ->
    App.LoginStateManager.get('currentState') == App.LoginStateManager.authenticated
