class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :contributor, null: false, foreign_key: true
      t.string :title
      t.date :event_date
      t.string :venue
      t.datetime :event_start_time
      t.datetime :event_end_time
      t.datetime :posting_start_time
      t.datetime :posting_end_time
      t.string :address
      t.integer :recruitment_numbers
      t.text :content
      t.integer :price

      t.timestamps
    end
  end
end
