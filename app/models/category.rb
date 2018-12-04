class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :comments, through: :images
  has_many :follows, dependent: :destroy
  belongs_to :user
  # acts_as_followable

  extend FriendlyId
  friendly_id :name, use: :slugged

  def is_follow(user)
    follows.where(user_id: user.id).exists?
  end
end
