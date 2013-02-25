App.StudyStateManager = Ember.StateManager.create
  initialState: 'idle'
  order: []

  idle: Ember.State.create
    initialize: ->
      manager.transitionTo 'initialized'
  initialized: Ember.State.create
    frontShowing: Ember.State.create
    backShowing: Ember.State.create
  finished: Ember.State.create

