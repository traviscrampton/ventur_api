class AddCreationPriv < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :can_create, :boolean, default: false
  end
end
