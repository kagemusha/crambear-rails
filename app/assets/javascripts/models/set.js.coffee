App.Set = DS.Model.extend
  cards: DS.hasMany 'App.Card'
  name: DS.attr 'string'

