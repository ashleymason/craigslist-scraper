class ListingsController < ApplicationController

  def index
    Listing.seed_table
    @current_listings = Listing.all
  end

  def new
    respond_to do |format|
      format.json { render json: listing }
    end
  end
  
  def create
    @listing = Listing.new(params[:listing])
    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing) }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end