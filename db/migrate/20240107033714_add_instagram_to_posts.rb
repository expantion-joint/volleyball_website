class AddInstagramToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :instagram_url, :string
    add_column :posts, :line_url, :string
    add_column :posts, :facebook_url, :string
    add_column :posts, :youtube_url, :string
    add_column :posts, :note_url, :string
    add_column :posts, :x_url, :string
  end
end
