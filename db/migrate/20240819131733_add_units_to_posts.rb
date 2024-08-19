class AddUnitsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :unit, :string
  end
end
