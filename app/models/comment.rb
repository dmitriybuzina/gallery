class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user

  validates :body, presence: true, allow_blank: false

  after_create :increment_count
  after_destroy :decrement_count

  private
  def decrement_count
    Category.decrement_counter(:counter, self.image.category.id)
  end

  def increment_count
    Category.increment_counter(:counter, self.image.category.id)
  end
end