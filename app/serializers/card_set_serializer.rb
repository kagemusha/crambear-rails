class CardSetSerializer < ActiveModel::Serializer
  attributes :id, :name, :cards_count
  has_many :cards
  has_many :labels
  embed :ids, :include=>true
end


