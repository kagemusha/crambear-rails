App.Adapter = DS.RESTAdapter.extend
  bulkCommit: false

DS.RESTAdapter.registerTransform(
  'array'
  serialize: (value)-> value
  deserialize: (value)-> value
)


App.Store = DS.Store.extend
  revision: 12,
  adapter:  App.Adapter.create()



