class Cleanup < ActiveRecord::Migration[5.2]
  def change
    drop_table :profile_infos
    remove_attachment :chapters, :image
    remove_attachment :gear_items, :product_images
    remove_attachment :journals, :banner_image
  end
end
