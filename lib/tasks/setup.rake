namespace :setup do
  desc "TODO"
  task migrate_images: :environment do
    path = "#{Rails.root}/app/assets/images/"
    User.create(email: '123@qwerty.com', first_name: 'Name', last_name: 'Surname', password: '123456')
    Dir.children(path).each do |dir|
      next unless File.directory?("#{path}#{dir}")
      category = Category.new(name: dir, user_id: User.first.id)
      puts "Create category #{category.name}" if category.save
      add_images("#{path}#{dir}", category.id)
    end
  end

  def add_images(path, category_id)
    Dir.children(path).each_with_index do |img, i|
      image = Image.new(name: "image#{i}", category_id: category_id, file: File.new("#{path}/#{img}"))
      puts "Add image #{image.file}" if image.save
    end
  end
end
