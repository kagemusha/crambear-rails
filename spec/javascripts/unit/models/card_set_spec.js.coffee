#= require spec_helper
#= require models/card_set

describe "App.CardSet", ->
  #beforeEach (done)->
  #afterEach ->

  it "is a DS.Model", ->
    assert.ok App.CardSet
    assert.ok DS.Model.detect(App.CardSet)