require 'nokogiri'
require 'open-uri'

ActiveAdmin.register_page "Parser_images" do

  # permit_params :url
  page_action :foo, method: :post do

  end

  content do
    form action: "parser_images/foo", method: :post do |f|
      f.input :url, type: :text, name: 'url'
      f.input :submit, type: :submit
    end
  end
end