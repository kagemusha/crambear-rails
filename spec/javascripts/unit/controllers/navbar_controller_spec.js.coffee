#= require spec_helper
#= require controllers/controllers


describe "App.NavbarController", ->
  it "is an Ember.ObjectController", ->
    assert.ok App.NavbarController
    assert.ok Ember.ObjectController.detect(App.NavbarController)