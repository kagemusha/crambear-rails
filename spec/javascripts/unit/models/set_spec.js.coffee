#= require spec_helper
#= require models/set

describe "App.Set", ->
  #beforeEach (done)->
  #afterEach ->

  it "is a DS.Model", ->
    assert.ok App.Set
    assert.ok DS.Model.detect(App.Set)