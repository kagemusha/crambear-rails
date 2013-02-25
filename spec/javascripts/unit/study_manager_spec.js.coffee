#= require spec_helper
#= require state_managers/study_manager

describe "App.StudyManager", ->

  it "should start in idle state", ->
    App.StudyStateManager.get('currentState.name') == "idle"

  it "on initialized, should have a set", ->

  it "on initialized, should have a card order", ->

  it "on initialized, should be showing the front", ->