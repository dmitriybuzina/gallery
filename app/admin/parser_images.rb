require 'nokogiri'
require 'open-uri'

ActiveAdmin.register_page "Parser images" do

  page_action :parser, method: :post do
    doc = Nokogiri::HTML(open(params[:parser_images][:url]))
    @images = doc.css('img')
    # @image_tags.css('img').attr('src').each do |i|
    #   puts i
    # end
    # @images = doc.search('img').map{ |img| img['src']}
    # @images.each do |image|
    #   image = "#{params[:parser_images][:url]}/#{image}"
    # end
    # puts @images

    render 'admin/parser_images/images', image: @images
    #render inline: "<% @images.each do |image| %><p><%= image_tag(image,url) %></p><% end %>"
  end

  content do
    render 'admin/parser_images/form'
  end

end