#= require spec_helper
#= require router

describe "App.SetsRoute", ->
  it "is an Ember.Route", ->
    assert.ok App.SetsRoute
    assert.ok Ember.Route.detect App.SetsRoute
