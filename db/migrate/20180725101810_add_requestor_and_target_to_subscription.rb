class AddRequestorAndTargetToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :requestor_id, :integer
    add_column :subscriptions, :target_id, :integer
  end
end
