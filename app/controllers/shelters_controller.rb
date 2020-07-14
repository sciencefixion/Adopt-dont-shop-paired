class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      redirect_to "/shelters"
    else
      flash[:notice] = "Shelter could not be created: incomplete information"
      redirect_to "/shelters/new"
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
    @shelter_reviews = @shelter.shelter_reviews
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    pets = Pet.where("shelter_id = #{@shelter.id}")
    reviews = ShelterReview.where("shelter_id = #{@shelter.id}")
    can_destroy = true
    unless pets.empty?
      pets.each do |pet|
        can_destroy = false if !pet.adoptable?
      end
    end
    unless !can_destroy
      pets.destroy_all
      reviews.destroy_all
    end
    if can_destroy
      @shelter.destroy
      redirect_to '/shelters'
    else
      flash[:notice] = "Shelter #{@shelter.name} cannot be deleted: contains pet(s) pending adoption"
      redirect_to "/shelters/#{@shelter.id}"
    end
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  def new_review
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
