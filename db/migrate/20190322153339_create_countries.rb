class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :country_code
      t.float :latitude
      t.float :longitude
      t.timestamps
    end

    create_table :included_countries do |t|
      t.integer :journal_id
      t.integer :country_id
      t.timestamps
    end
  end
end
