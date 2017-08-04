class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  class Listing
    def initialize(title, price, date)
      @price = price
      @title = title
      @date = date
    end

    attr_reader :title
    attr_reader :price
    attr_reader :date
  end


  def scrape_craigslist_apartments
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://raleigh.craigslist.org/search/apa"))

      listings = doc.css('.result-row')
      @listing_array = []

      listings.each do |l|
        title = l.css('p.result-info').css('.result-title').text
        price = l.css('p.result-info').css('.result-meta').css('.result-price').text
        date = l.css('p.result-info').css('.result-date')[0].values.third
        
        @listing_array << Listing.new(title, price, date)
      end

      render template: 'local_listings'
  end
end
