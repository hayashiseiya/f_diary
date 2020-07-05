# --path vendor/bundle で bundle install したため
require 'bundler'
Bundler.require

require "nokogiri"
require "open-uri"
require "pry"

class Scraping
  class Freitag
    class << self
      def run
        bags_dom = open(base_url_of_bags) do |f|
          charset = f.charset
          f.read
        end

        bags_page = Nokogiri::HTML.parse(bags_dom)
        bags = bags_page.search(".neo-unikat-model").map do |bag|
          name_with_type = bag.search(".content-wrapper h3").text
          type = name_with_type.split(" ")[0]
          name = name_with_type.split(" ")[1]

          price = bag.search(".content-wrapper .field-commerce-price").text.strip
          list_url = bag.search(".sector-model-unikat-pictures-json").attribute("data-model-url").value
          image_url = bag.search(".sector-model-unikat-pictures-json img").attribute("src").value
          # code = list_url の末尾のコード

          {
            type: type,
            name: name,
            price: price,
            list_url: list_url,
            image_url: image_url,
          }
        end
      end

      private

        def base_url_of_bags
          "https://www.freitag.ch/en/shop/bags"
        end
    end
  end
end

def lambda_handler

end

Scraping::Freitag.run