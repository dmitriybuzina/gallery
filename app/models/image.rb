class Image < ApplicationRecord
  belongs_to :category, counter_cache: :counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :file, FileUploader
  validates :file, file_size: { less_than: 50.megabytes }, presence: true

  def is_liked(user_id)
    likes.where(user_id: user_id).exists?
  end

end
