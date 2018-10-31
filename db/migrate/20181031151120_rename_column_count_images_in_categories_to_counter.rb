class RenameColumnCountImagesInCategoriesToCounter < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :count_images, :counter
  end
end
