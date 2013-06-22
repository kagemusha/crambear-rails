App.LabelView = Em.View.extend
  templateName: 'labels/new'
  click: (e)->
    log.log "LabelsViewClick"
    return if @get('controller.isEditingName')
    @get('controller').editName()
    this.$('input:first').focus()
  keyPress: (e)->
    log.log "keprese #{e.keyCode}"
    if e.keyCode == 13
      @get('controller').update()
      @set 'controller.isEditingName', false
#  didInsertElement: ->
#    log.log "CardSetNameView: didInsertElem"
#    this.$('input:first').focus()
  giveFocusToInput: ((view, key) ->
    log.log "focus"
    log.log Ember.inspect @
    @.$('input:first').focus() if @get('controller.isEditingName')
#    if view.get('content.isEditingName')
#      # We are getting called before the view has updated.
#      # Lets wait to the next free moment to do our work.
#      Ember.run.next @, -> @$("input[type=text]").focus()
  ).observes('controller.isEditingName')
