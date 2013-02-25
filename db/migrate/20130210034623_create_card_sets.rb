class CreateCardSets < ActiveRecord::Migration
  def self.up
    create_table :card_sets do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :access
      t.integer :cards_count
      t.timestamps
    end
  end

  def self.down
    drop_table :card_sets
  end
end
