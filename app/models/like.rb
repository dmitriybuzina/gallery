class Like < ApplicationRecord
  belongs_to :user
  belongs_to :image

  after_create :increment_count
  after_destroy :decrement_count

  private
  def decrement_count
    Category.decrement_counter(:counter, self.image.category.id)
    Image.decrement_counter(:count_likes, image)
  end

  def increment_count
    Category.increment_counter(:counter, self.image.category.id)
    Image.increment_counter(:count_likes, image)
  end
end
