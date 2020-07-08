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
    if shelter_review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Shelter Review Not Created! Required Content Missing."
      render :new
    end
  end

  def edit
    @shelter_review = ShelterReview.find(params[:id])
    @shelter = Shelter.find(@shelter_review.shelter_id)
  end

  def update
    @shelter_review = ShelterReview.find(params[:id])
    @shelter_review.update(shelter_review_params)
    if @shelter_review.valid?
      redirect_to "/shelters/#{@shelter_review.shelter_id}/"
    else
      flash[:notice] = "Shelter Review Not Updated! Required Content Missing."
      render :edit
    end
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
