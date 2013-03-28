EMBER_CARDS = [
    ["What are the Ember MVC building blocks?","routes, controllers, templates and views"],
    ["What is Ember's test data store adapter?","adapter: 'DS.FixtureAdapter'"],
    ["What controller property allows it to access another controller?", "needs\n\nApp.NeedyController = Em.Controller.extend\n  needs: ['neededController']"],
    ["What setting allows you to output route transitions", "LOG_TRANSITIONS\n\nApp = Ember.Application.create({LOG_TRANSITIONS: true});"],
    ["How do you make a controller attribute depend on other things", "With the property method e.g. attribute: (someFunction).property('iDependOnThisProp', 'andThisProp')"]
]
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create! :name => "TestUser", :email => "test@test.com", :password => "tester", :password_confirmation => "tester"
em = CardSet.create!(name: "Ember")
EMBER_CARDS.each do |card|
  m.cards << Card.new(front: card[0], back: card[1])
end
user.card_sets << em
user.card_sets << CardSet.new(name: "Rails")
user.save!
