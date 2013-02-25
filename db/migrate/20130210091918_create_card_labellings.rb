class CreateCardLabellings < ActiveRecord::Migration
  def self.up
    create_table :card_labellings do |t|
      t.integer :card_id, :null=>false
      t.integer :label_id, :null=>false      
      #t.timestamps
    end
    drop_table :cards_labels

  end

  def self.down
    drop_table :card_labellings
  end
end
