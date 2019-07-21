class AddStravaToUser < ActiveRecord::Migration[5.2]
  def change
    create_table :strava_auths do |t|
      t.string :access_token, default: ""
      t.string :refresh_token, default: ""
      t.integer :user_id
      t.integer :expires_at
    end
  end
end
