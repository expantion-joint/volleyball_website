class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :usertype, :integer
  end
end
