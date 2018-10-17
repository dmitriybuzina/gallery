class Image < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  mount_uploader :file, FileUploader
  validates :file, file_size: { less_than: 50.megabytes }
  acts_as_likeable
end
