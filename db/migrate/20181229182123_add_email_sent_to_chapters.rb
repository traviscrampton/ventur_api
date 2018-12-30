class AddEmailSentToChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :email_sent, :boolean, default: false
  end
end
