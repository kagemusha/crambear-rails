App.Adapter = DS.RESTAdapter.extend
  bulkCommit: false


App.Store = DS.Store.extend
  revision: 12,
  adapter:  App.Adapter.create()


#App.Store = DS.Store.extend
#  revision: 11
#  adapter: 'DS.FixtureAdapter' #for testing

