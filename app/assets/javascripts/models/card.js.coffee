App.Card = DS.Model.extend
  list: DS.belongsTo 'App.Set'

  front: DS.attr 'string'
  back: DS.attr 'string'
