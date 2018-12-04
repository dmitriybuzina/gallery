class AddMainImageToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :main_image, :string
  end
end
