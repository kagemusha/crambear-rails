class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :card_set
  validates_presence_of :user
  validates_presence_of :card_set
  validates_presence_of :total
  #more validations
end
