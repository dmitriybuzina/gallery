class RemoveCachedFailedAttempts < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :cached_failed_attempts
  end
end
