class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.integer :recipient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
