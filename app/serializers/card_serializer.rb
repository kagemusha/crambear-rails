class CardSerializer < ActiveModel::Serializer
  attributes :id, :front, :back, :card_set_id, :label_ids
end
