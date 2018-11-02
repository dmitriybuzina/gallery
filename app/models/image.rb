class Image < ApplicationRecord
  belongs_to :category, counter_cache: :counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :file, FileUploader
  validates :file, file_size: { less_than: 50.megabytes }
end
