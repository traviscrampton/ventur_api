class AddColumnIncludedActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :cycle_routes, :included_activities, :text, default: ""
  end
end
