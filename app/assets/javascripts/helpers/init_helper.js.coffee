App.initApp = (currentUser) ->
  log.log "initApp"
  initHelperMethods()
  App.initCurrentUser currentUser
  App.LoginStateManager.transitionTo 'authenticated' if App.currentUser
  customizeViews()


App.initCurrentUser = (currentUser) ->
  log.info "current user: ", currentUser
  App.currentUser =  currentUser if currentUser?.email


initHelperMethods = ->
  App.authenticated = ->
    App.LoginStateManager.get('currentState') == App.LoginStateManager.authenticated

FOCUS_ELEM_SEL = '.focus'
customizeViews = ->
  Em.View.reopen
    didInsertElement: ->
      @_super()
      focusElem = if @.$(FOCUS_ELEM_SEL).length > 0 then FOCUS_ELEM_SEL else 'input:first'
      @.$(focusElem).focus()
