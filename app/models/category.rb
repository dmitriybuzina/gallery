class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :comments, through: :images
  has_many :follows, dependent: :destroy
  belongs_to :user
  # acts_as_followable

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def is_follow(user_id)
    follows.where(user_id: user_id).exists?
  end
end
