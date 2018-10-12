class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  acts_as_followable
end
