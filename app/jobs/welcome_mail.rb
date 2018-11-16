class WelcomeMail
  @queue = :welcome_mail

  def self.perform(user_id)
    UserMailer.with(user: User.find(user_id)).welcome_email.deliver_later
  end

end
