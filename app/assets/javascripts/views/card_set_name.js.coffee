App.CardSetNameView = Em.View.extend
  templateName: 'card_sets/set_name'
  click: (e)->
    return if e.target.tagName == "INPUT"
    log.log "CardSetNameViewClick"
    if @get('controller.isEditingName')
      log.log "setting unedit"
      @set('controller.isEditingName', false)
      return
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
    #log.log "focus"
    #log.log Ember.inspect @
    @.$('input:first').focus() if @get('controller.isEditingName')
#    if view.get('content.isEditingName')
#      # We are getting called before the view has updated.
#      # Lets wait to the next free moment to do our work.
#      Ember.run.next @, -> @$("input[type=text]").focus()
  ).observes('controller.isEditingName')
