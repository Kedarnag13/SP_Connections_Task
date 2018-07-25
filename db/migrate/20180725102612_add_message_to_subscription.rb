class AddMessageToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :message, :string
  end
end
