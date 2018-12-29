class CreateJournalFollowTables < ActiveRecord::Migration[5.2]
  def change
    create_table :journal_follows do |t|
      t.integer :user_id
      t.integer :journal_id
      t.string :user_email
      t.timestamps
    end
  end
end
