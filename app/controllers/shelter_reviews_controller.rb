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
    if shelter_review.save
      redirect_to "/shelters/#{shelter.id}/shelter_reviews"
    else
      flash[:notice] = "Could not create shelter review: #{shelter_review.errors.full_messages}"
      redirect_to "/shelters/#{shelter.id}/shelter_reviews/new"
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
      flash[:notice] = "Could not update shelter review: #{@shelter_review.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    @shelter_review = ShelterReview.find(params[:id])
    shelter_id = @shelter_review.shelter_id
    ShelterReview.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
