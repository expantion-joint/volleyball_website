class AddDetailsToTitles < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :type, :integer
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
    add_column :posts, :category, :string
  end
end
