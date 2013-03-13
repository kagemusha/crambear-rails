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
user.card_sets << em
user.card_sets << CardSet.new(name: "Rails")
user.save!
