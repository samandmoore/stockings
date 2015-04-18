class Entry < ActiveRecord::Base

  belongs_to :user
  belongs_to :match
  belongs_to :tech_ticker, class_name: 'Ticker'

  validate :tickers_fulfill_requirements
  validates :user_id, uniqueness: { scope: :match_id }

  def editable?
    !match.started?
  end

  private 

  def tickers_fulfill_requirements
    if tech_ticker && tech_ticker.sector != 'technology'
      errors.add :tech_ticker_id, 'incorrect ticker sector for tech_ticker'
    end
  end
end
