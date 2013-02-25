class CreateUserLabels < ActiveRecord::Migration
  def self.up
    create_table :user_labels do |t|
      t.integer :user_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :user_labels
  end
end
