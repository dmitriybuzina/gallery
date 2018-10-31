module ApplicationHelper

  def top_categories
    @categories = Category.order('counter DESC').limit(5)
  end
end
