class Card < ActiveRecord::Base
  belongs_to :card_set, :counter_cache => true


end
