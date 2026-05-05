class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @date = params[:date]
  end

  def confirm
    @reservation_params = reservation_params
    session[:reservation_params] = @reservation_params
  end

  def create
    @reservation = Reservation.new(session[:reservation_params])
    if @reservation.save
      session.delete(:reservation_params)
      redirect_to complete_reservation_path(@reservation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def complete
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :daily_slot_date, :personal_name, :email,
      reservation_details_attributes: [:person_type, :number_of_people, :price, :subtotal]
    )
  end
end
