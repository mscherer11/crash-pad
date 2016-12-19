class Api::V1::ReviewsController < ApplicationController
  def index
    if authenticated_user
      render json: Listing.find(params[:listing_id]).reviews.all
    else
      render :json => {:error => 'forbidden'}.to_json, :status => 403
    end
  end

  def create
    if authenticated_user
      listing = Listing.find(params[:listing_id])
      review = listing.reviews.create(body: params[:body], user_id: authenticated_user.id)
      render :json => review.to_json, :status => 201
    else
      render :json => {:error => 'forbidden'}.to_json, :status => 403
    end
  end

  private

  def authenticated_user
    User.find_by(api_key: params[:api_key])
  end

end