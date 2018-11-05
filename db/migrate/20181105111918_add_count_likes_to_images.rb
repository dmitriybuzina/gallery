class AddCountLikesToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :count_likes, :int
  end
end
