class AddStatusToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :status, :boolean, default: false
  end
end
