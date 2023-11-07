class CreateContributors < ActiveRecord::Migration[7.0]
  def change
    create_table :contributors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :self_introduction

      t.timestamps
    end
  end
end
