App.Authentication ||= {}
App.Authentication.login = (route) ->
  $.ajax
    url: App.urls.login
    type: "POST"
    data:
      "user[email]": route.currentModel.email
      "user[password]": route.currentModel.password
    success: (data) ->
      App.currentUser = data.user
      App.LoginStateManager.transitionTo "authenticated"
      route.transitionTo 'card_sets'
    error: (jqXHR, textStatus, errorThrown) ->
      if jqXHR.status==401
        route.controllerFor('login').set "errorMsg", "That email/password combo didn't work.  Please try again"

App.Authentication.logout = (transition) ->
  log.info "Logging out..."
  $.ajax
    url: App.urls.logout
    type: "DELETE"
    dataType: "json"
    success: (data, textStatus, jqXHR) ->
      $('meta[name="csrf-token"]').attr('content', data['csrf-token'])
      $('meta[name="csrf-param"]').attr('content', data['csrf-param'])
      log.info "Logged out on server"
      App.currentUser = null
      App.LoginStateManager.transitionTo 'notAuthenticated'
      transition()
    error: (jqXHR, textStatus, errorThrown) ->
      #Devise logout sends a 204, which JQuery interprests as error so handle here
      if jqXHR.status==204
        logoutSuccess(transition)
      else
        alert "Error logging out: #{errorThrown}"


App.Authentication.register = (route) ->
  log.log "App.Authentication.register..."
  $.ajax
    url: App.urls.register
    type: "POST"
    data:
    #would be nice if could do something like this
    #user: @currentModel.getJSON
    #(perhaps there is, but couldn't find)
      "user[name]": route.currentModel.name
      "user[email]": route.currentModel.email
      "user[password]": route.currentModel.password
      "user[password_confirmation]": route.currentModel.password_confirmation
    success: (data) ->
      App.currentUser =  data.user
      App.LoginStateManager.transitionTo "authenticated"
      route.transitionTo 'home'
    error: (jqXHR, textStatus, errorThrown) ->
      route.controllerFor('registration').set "errorMsg", "Registration error.  Please try again"



