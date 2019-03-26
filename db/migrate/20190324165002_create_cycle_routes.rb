class CreateCycleRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :cycle_routes do |t|
      t.integer :routable_id
      t.string :routable_type
      t.text :polylines, default: ""
      t.float :latitude
      t.float :longitude
      t.float :longitude_delta
      t.float :latitude_delta
    end
  end
end
