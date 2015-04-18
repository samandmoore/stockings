class EntriesController < ApplicationController

  def index
    @entries = current_user.entries
  end

  def create
    @match = Match.find params[:match_id]
    @entry = @match.entries.find_or_create_by!(user: current_user)

    redirect_to match_entry_path(@match, @entry)
  end

  def edit
    @match = Match.find params[:match_id]
    @entry = current_user.entries.find params[:id]
  end

  def update
    @match = Match.find params[:match_id]
    @entry = current_user.entries.find params[:id]

    if @entry.update(update_params)
      redirect_to match_entry_path(@match, @entry)
    else
      render :edit
    end
  end

  def show
    @match = Match.find params[:match_id]
    @entry = current_user.entries.find params[:id]
  end

  private

  def update_params
    params.require(:entry).permit(:tech_ticker_id)
  end
end