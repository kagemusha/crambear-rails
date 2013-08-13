class CardSerializer < ActiveModel::Serializer
  attributes :id, :front, :back, :card_set_id, :label_ids, :archived, :created_at, :updated_at
end
