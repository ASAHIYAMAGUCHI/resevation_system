class DailySlotsController < ApplicationController
  def index
    @daily_slots = DailySlot.all
  end

  def show
    @daily_slot = DailySlot.find(params[:id])
  end
end
