class CreateDate < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :date, :datetime
  end
end
