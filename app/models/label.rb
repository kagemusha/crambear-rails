class Label < ActiveRecord::Base
  belongs_to :card_set
  attr_accessible :name
  validates_uniqueness_of :name, :scope => :card_set_id
end
