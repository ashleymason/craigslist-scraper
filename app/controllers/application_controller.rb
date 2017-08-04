class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def scrape_craigslist_apartments
    require 'open-uri'
      Listing.seed_table
      @current_listings = Listing.all
      render template: 'local_listings'
  end
end
