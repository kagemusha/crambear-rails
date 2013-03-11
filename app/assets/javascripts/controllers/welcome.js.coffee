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


