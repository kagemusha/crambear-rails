class Card < ActiveRecord::Base
  belongs_to :card_set, :counter_cache => true
  attr_accessible :front, :back, :archived, :label_ids, :last_viewed, :times_viewed, :times_correct, :recent_corrects


end
