#App.CardsTableRowView = Ember.CollectionView.extend
#  tagName: 'tbody'
#  emptyView: Ember.View.extend(template: Ember.Handlebars.compile '<td colspan="4">No cards, yet.</td>')
#  controller: "CardsTableRowController"
#
#  didInsertElement: ->
#    log.log "CardsTableRowView.didInsertElem"
#    this.$('input:first').focus()
#
#  itemViewClass: Ember.View.extend
#    templateName: 'cards/table_row'
#    classNameBindings: ['content.isEditing']
#
#    giveFocusToInput: ((view, key) =>
#      if view.get('content.isEditing')
#        # We are getting called before the view has updated.
#        # Lets wait to the next free moment to do our work.
#        Ember.run.next @, -> @$("input[type=text]").focus()
#    ).observes('content.isEditing')
#
#
#    keyDown: (event) ->
#      if @get('content.isEditing')
#        cardController = @get 'content'
#        action = {27: 'cancelEditMode', 13: 'save'}[event.keyCode]
#
#        if action
#          $(event.target).blur()
#          cardController[action]()
#
#    doubleClick: (event) ->
#      unless @get('content.isEditing')
#        @clearTextSelection()
#        @get('content').enterEditMode()
#
#
#    clearTextSelection: ->
#      if window.getSelection
#        window.getSelection().removeAllRanges()
#      else if document.selection
#        document.selection.empty()
