class Listing < ActiveRecord::Base
  
  def self.empty_table
    old_seeds = Listing.all
    old_seeds.each do |l|
      l.destroy
    end
  end

  def self.seed_table
    # destroy all the old listings before we make new ones
    Listing.empty_table

    # after we destroy all the old seeds, scrape the craigslist page
    # for new listings
    doc = Nokogiri::HTML(open("https://raleigh.craigslist.org/search/apa"))

    listings = doc.css('.result-row')

    listings.each do |l|
      # create a new listing object with the info we scrape from each page item

      title = l.css('p.result-info').css('.result-title').text
      price = l.css('p.result-info').css('.result-meta').css('.result-price').text
      date = l.css('p.result-info').css('.result-date')[0].values.second

      list = Listing.create(:title => title, :price => price, :post_date => date)
      list.save
    end
  end

end