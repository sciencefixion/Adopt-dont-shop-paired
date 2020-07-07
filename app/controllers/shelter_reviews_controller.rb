class ShelterReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter_review = shelter.shelter_reviews.create(shelter_review_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
