# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create! :name => "TestUser", :email => "test@test.com", :password => "tester", :password_confirmation => "tester"
em = CardSet.create!(name: "Ember")
em.cards << Card.new(front: "What are the Ember MVC building blocks?", back: "routes, controllers, templates and views")
em.cards << Card.new(front: "What is Ember's test data store adapter?", back: "adapter: 'DS.FixtureAdapter'")
em.cards << Card.new(front: "What controller property allows it to access another controller?", back: "needs\n\nApp.NeedyController = Em.Controller.extend\n  needs: ['neededController']")
em.cards << Card.new(front: "What setting allows you to output route transitions", back: "LOG_TRANSITIONS\n\nApp = Ember.Application.create({LOG_TRANSITIONS: true});")


user.card_sets << em
user.card_sets << CardSet.new(name: "Rails")
user.save!
