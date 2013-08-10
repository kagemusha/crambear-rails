
App.MenuItem = Ember.View.extend
  templateName: "comps/menu_item"
  tagName: 'a'
  classNames: ["btn"]
  attributeBindings: ['href']

App.ArrayCheckbox = Em.Checkbox.extend
  choices: []
  choicesBinding: null

  checked: (->
    choices = @get('choices')
    choices.contains(@get('content'))
  ).property('content', 'choices.@each')

  click: (evt) ->
    isPresent = @get('checked')
    choices   = @get('choices')
    choice      = @get('content')

    if (!isPresent)
      choices.pushObject(choice)
    else
      choices.removeObject(choice)
