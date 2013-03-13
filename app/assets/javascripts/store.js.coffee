App.Adapter = DS.RESTAdapter.extend
  bulkCommit: false

App.Adapter.map 'App.CardSet',
  cards:
    embedded: 'always'


App.Store = DS.Store.extend
  revision: 11,
  adapter:  App.Adapter.create()




#App.Store = DS.Store.extend
#  revision: 11
#  adapter: 'DS.FixtureAdapter' #for testing

