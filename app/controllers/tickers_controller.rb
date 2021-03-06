class TickersController < ApplicationController

  def show
    @ticker = Ticker.find params[:id]
  end

  def edit
    @match = Match.find(params[:match_id])
    @entry = current_user.entries.find(params[:entry_id])
    @ticker_slot = params[:id]

    if Ticker.respond_to?(params[:id])
      @tickers = Ticker.public_send(params[:id])
    else
      @tickers = Ticker.all.where.not(id: @entry.ticker_ids)
    end
  end

  def update
    match = Match.find params[:match_id]
    entry = current_user.entries.find params[:entry_id]
    ticker = Ticker.find update_params[:id]
    entry.public_send("#{params[:id]}_ticker=", ticker)

    entry.save!

    redirect_to edit_match_entry_path(match, entry), flash: { success: "Added #{ticker.symbol} to portfolio." }
  end

  private

  def update_params
    params.require(:ticker).permit(:id)
  end
end
