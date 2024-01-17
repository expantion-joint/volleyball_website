class AddDetailsToContributors < ActiveRecord::Migration[7.0]
  def change
    add_column :contributors, :club_name1, :string
    add_column :contributors, :club_name2, :string
    add_column :contributors, :club_name3, :string
    add_column :contributors, :club_name4, :string
    add_column :contributors, :club_name5, :string
  end
end
