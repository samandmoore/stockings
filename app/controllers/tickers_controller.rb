class TickersController < ApplicationController

  def show
    @ticker = Ticker.find params[:id]
  end
end