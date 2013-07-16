App.CardLabelsView = Em.CollectionView.extend
  classNames: ['card-labels']
  tagName: 'ul'
  itemViewClass: Em.View.extend
    templateName: 'cards/label-choice'