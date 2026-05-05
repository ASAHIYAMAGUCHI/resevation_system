class DailySlotsController < ApplicationController
  def index
    @daily_slots = DailySlot.order(:applicable_date)
  end

  def show
    @daily_slot = DailySlot.find(params[:id])
  end
end
