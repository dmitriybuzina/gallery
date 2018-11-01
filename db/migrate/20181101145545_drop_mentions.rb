class DropMentions < ActiveRecord::Migration[5.2]
  def change
    drop_table :mentions
  end
end
