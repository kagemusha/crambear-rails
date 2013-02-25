class CreateCardsLabels < ActiveRecord::Migration
  def self.up
    create_table :cards_labels, :id => false do |t|
      #remove primary key
      t.integer :card_id
      t.integer :label_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cards_labels
  end
end
