class Entry < ActiveRecord::Base

  belongs_to :user
  belongs_to :match
  belongs_to :tech_ticker, class_name: 'Ticker'

  validates :user_id, uniqueness: { scope: :match_id }

  validates :tech_ticker_id, inclusion: { in: Ticker.technology.ids, allow_nil: true }
  #validates :financial_services_ticker_id, inclusion: { in: Ticker.technology.ids, allow_nil: true }

  def editable?
    !match.started?
  end
end
