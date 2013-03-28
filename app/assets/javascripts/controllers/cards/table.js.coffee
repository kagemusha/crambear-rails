App.CardsTableController = Em.ArrayController.extend
  needs: ['cardSet']
  itemController: 'CardsTableRow'
  isAddingNew: false
