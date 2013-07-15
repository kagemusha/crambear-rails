App.Mixins.EditState = Ember.Mixin.create({
state: "viewing",
isViewing: Em.computed.equal('state', 'viewing'),
isEditing: Em.computed.equal('state', 'editing'),
isAdding: Em.computed.equal('state', 'adding')
})
