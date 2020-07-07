class ShelterReviewsController < ApplicationController
  def index
    @shelter_reviews = ShelterReview.all
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    shelter_review = shelter.shelter_reviews.create(shelter_review_params)
    shelter_review.save
    redirect_to "/shelters/#{shelter.id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
