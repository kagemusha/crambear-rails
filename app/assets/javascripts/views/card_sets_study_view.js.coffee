App.CardSetsStudyView = Em.View.extend
  click: (e)->
    log.log "CardSetsStudyViewClick", e.target
    if e.target.id=="cardFront" and @get("controller.showingFront")
      @get("controller").flip()
