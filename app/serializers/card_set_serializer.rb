class CardSetSerializer < ActiveModel::Serializer
  attributes :id, :name, :cards_count
  has_many :cards
  embed :ids, :include=>true
end


