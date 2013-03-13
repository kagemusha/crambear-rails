App.User  = DS.Model.extend
  cards:  DS.hasMany 'App.CardSets'
  name:   DS.attr('string')
  email:  DS.attr('string')
