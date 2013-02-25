class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :card_set_id
      t.text :labels_array
      t.integer :total, :null => false
      t.integer :one_try
      t.integer :two_tries
      t.integer :three_more_tries
      t.timestamps
    end
  end
end
