App.CardsTableController = Em.ArrayController.extend
  needs: ['cardSet']
  itemController: 'CardTableRow'
  isAddingNew: false
