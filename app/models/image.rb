class Image < ApplicationRecord
  belongs_to :category, counter_cache: :counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :file, FileUploader
  validates :file, file_size: { less_than: 50.megabytes }, presence: true

  def is_liked(user)
    likes.where(user_id: user.id).exists?
  end

end
