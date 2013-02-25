class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :card_set_id
      t.boolean :archived, :default=>false
      t.text :front
      t.text :back
      t.text :labels_array
      t.datetime :last_viewed
      t.integer :times_viewed
      t.integer :times_correct
      t.integer :recent_corrects
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
