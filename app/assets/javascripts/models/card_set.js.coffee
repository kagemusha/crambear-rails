App.CardSet = DS.Model.extend
  cards: DS.hasMany 'App.Card'
  cardsCount: DS.attr 'number'
  name: DS.attr 'string'

