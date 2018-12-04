require 'nokogiri'
require 'open-uri'

ActiveAdmin.register_page "Parser images" do

  page_action :parser, method: :post do
    doc = Nokogiri::HTML(open(params[:parser_images][:url]))
    @images = doc.css('img')
    render 'admin/parser_images/images', image: @images
  end

  content do
    render 'admin/parser_images/form'
  end

end