class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.string :title
      t.string :public_or_private

      t.timestamps
    end
  end
end
