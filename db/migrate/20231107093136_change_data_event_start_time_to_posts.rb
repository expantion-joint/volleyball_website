class ChangeDataEventStartTimeToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :event_start_time, :time
    change_column :posts, :event_end_time, :time
  end
end
