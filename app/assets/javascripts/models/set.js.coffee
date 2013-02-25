App.Set = DS.Model.extend
  cards: DS.hasMany 'App.Card'
  name: DS.attr 'string'

#  minutesLeftToComplete: Ember.computed ->
#    total = @get('tasks').getEach('minutesLeftToComplete').reduce ((sum, min) -> sum + parseInt(min, 10)), 0
#    if total is 0 then null else total
#  .property('tasks.@each.minutesLeftToComplete')
