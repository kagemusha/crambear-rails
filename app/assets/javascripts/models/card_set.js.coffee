App.CardSet = DS.Model.extend
  cards: DS.hasMany 'App.Card'
  labels: DS.hasMany 'App.Label'
  cardsCount: DS.attr 'number'
  name: DS.attr 'string'

