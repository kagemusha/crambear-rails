class Label < ActiveRecord::Base
  belongs_to :card_set
  validates_uniqueness_of :name, :scope => :card_set_id
end
