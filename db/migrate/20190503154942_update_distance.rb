class UpdateDistance < ActiveRecord::Migration[5.2]
  def change
    add_column :distances, :distance_type, :integer, default: 0
    add_column :distances, :mile_amount, :decimal, precision: 8, scale: 2
    rename_column :distances, :amount, :kilometer_amount
  end
end
