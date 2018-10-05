class AddIdCategoryToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :id_category, :int
  end
end
