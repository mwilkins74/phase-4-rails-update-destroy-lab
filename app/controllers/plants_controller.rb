class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant
  end

  def is_in_stock
    plant = find_plant
    plant.update(:is_in_stock => false)
    render json: plant
  end

  # DELETE /plants/:id
  def destroy
    plant = Plant.find_by(id: params[:id])
    plant.destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def render_not_found_response
    render json: {error: "Boogers not found"}, status: :not_found
  end
end
