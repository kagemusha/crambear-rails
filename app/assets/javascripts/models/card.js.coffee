App.Card = DS.Model.extend
  cardSet: DS.belongsTo 'App.CardSet'

  front: DS.attr 'string'
  back: DS.attr 'string'
  archived: DS.attr 'boolean'
  labelIds: DS.attr 'array'
  createdAt: DS.attr 'date'
  updatedAt: DS.attr 'date'
