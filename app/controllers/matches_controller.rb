class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def show
    @match = Match.find params[:id]
  end

  def create
    @match = Match.open.tomorrow.find_or_initialize_by(create_params)

    if @match.save
      redirect_to @match
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:match).permit(:duration, :max_entries, :wager_cents)
  end
end
