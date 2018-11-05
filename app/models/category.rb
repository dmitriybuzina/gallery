class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :comments, through: :images
  belongs_to :user
  acts_as_followable
end
