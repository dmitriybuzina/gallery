class NewImageMail

  @queue = :new_image_mail

  def self.perform(user_id, image_id)
    UserMailer.with(user: User.find(user_id), image: Image.find(image_id)).new_image_email.deliver_now
  end

end