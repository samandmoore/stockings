class Tickers::DetailsController < ApplicationController
  def show
    @match = Match.find params[:match_id]
    @entry = current_user.entries.find params[:entry_id]
    @ticker = Ticker.find params[:id]
    @ticker_param_name = params[:ticker_id]
  end
end