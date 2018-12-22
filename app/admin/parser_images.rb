require 'nokogiri'
require 'open-uri'

ActiveAdmin.register_page "Parser images" do

  page_action :parser, method: :post do
    uri = request.host
    purs uri
    doc = Nokogiri::HTML(open(params[:parser_images][:url]))
    @images = doc.xpath("//img[@src]")
    @images.inject([]) do |uris, image|
      uris << "#{ URL_PREFIX }/#{ image.attr('src').strip }"
    end.uniq
    render 'admin/parser_images/images', image: @images
  end

  content do
    render 'admin/parser_images/form'
  end
end