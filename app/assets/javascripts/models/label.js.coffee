App.Label = DS.Model.extend
  cardSet: DS.belongsTo 'App.CardSet'

  name: DS.attr 'string'
