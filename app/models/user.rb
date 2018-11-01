class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
