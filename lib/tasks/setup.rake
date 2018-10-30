namespace :setup do
  desc "TODO"
  task migrate_images: :environment do
    path = "#{Rails.root}/app/assets/images/"
    Dir.children(path).each do |dir|
      if File.directory?("#{path}#{dir}")
        category = Category.new
        category.name = dir
        category.user_id = 1
        if category.save
          puts "Create category #{category.name}"
        end
        add_images("#{path}#{dir}", category.id)
      end
    end
  end

  def add_images(path, category_id)
    Dir.children(path).each_with_index do |img, i|
      image = Image.new
      image.name = "image#{i}"
      image.category_id = category_id
      image.file = File.new("#{path}/#{img}")
      if image.save
        puts "Add image #{image.file}"
      end
    end
  end

end
