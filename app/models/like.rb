class Like < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :image, polymorphic: true
end
