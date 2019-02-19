class FlightsController < ApplicationController
  before_action :find_flight, only: [:show, :edit, :update, :destroy]
  def index
    @flights = policy_scope(Flight).order(created_at: :desc)
  end

  def show; end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)
    if @flight.save
      redirect_to @flight
    else
      render :new
    end
  end

  def edit; end

  def update
    @flight.update(flight_params)
    redirect_to @flight
  end

  def destroy
    @flight.destroy
    redirect_to flights_companies_path
  end

  private

  def find_flight
    @flight = Flight.find(params[:id])
    authorize @flight
  end

  def flight_params
    params.require(:flight).permit(:origin, :destiny, :date, :capacity, :price, :description)
  end
end
