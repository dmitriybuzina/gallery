class FollowMail

  @queue = :follow_mail

  def self.perform(user_id, category_id)
    UserMailer.with(user: User.find(user_id), category: Category.find(category_id)).follow_email.deliver_now
  end

end