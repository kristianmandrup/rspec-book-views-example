class AddLimitToSubscription < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :limit, :integer
  end

  def self.down
    remove_column :subscriptions, :limit
  end
end
