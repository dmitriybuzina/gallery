class RenameColumnPathinImagestoName < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :path, :name
  end
end
