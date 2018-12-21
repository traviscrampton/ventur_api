class Cleanup < ActiveRecord::Migration[5.2]
  def change
    drop_table :profile_infos
  end
end
