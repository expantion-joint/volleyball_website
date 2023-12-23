class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :content
      t.text :answer

      t.timestamps
    end
  end
end
