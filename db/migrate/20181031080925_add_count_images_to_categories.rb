class AddCountImagesToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :count_images, :int
  end
end
