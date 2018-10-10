class RemoveIdCategoryFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :id_category, :integer
  end
end
