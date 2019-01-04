require 'nokogiri'
require 'open-uri'

ActiveAdmin.register_page "Parser images" do
  page_action :parser, method: :post do
    # uri = request.host
    puts params[:parser_images][:url]
    uri = uri?(params[:parser_images][:url])
    puts uri
    doc = Nokogiri::HTML(open(params[:parser_images][:url]))
    @images = doc.css('img')
    @images.each do |image|
      unless uri?(image.attributes["src"].value)
        image.attributes["src"].value = "#{params[:parser_images][:url]}#{image.attributes["src"].value}"
        puts image
      end
    end
    render 'admin/parser_images/images', image: @images
  end

  content do
    render 'admin/parser_images/form'
  end
end

def uri?(string)
  uri = URI.parse(string)
  %w( http https ).include?(uri.scheme)
rescue URI::BadURIError
  false
rescue URI::InvalidURIError
  false
end