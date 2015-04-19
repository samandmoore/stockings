class Entry < ActiveRecord::Base

  belongs_to :user
  belongs_to :match
  belongs_to :technology_ticker, class_name: 'Ticker'
  belongs_to :financial_services_ticker, class_name: 'Ticker'
  belongs_to :telecommunications_ticker, class_name: 'Ticker'
  belongs_to :energy_ticker, class_name: 'Ticker'
  belongs_to :healthcare_ticker, class_name: 'Ticker'
  belongs_to :flex_1_ticker, class_name: 'Ticker'
  belongs_to :flex_2_ticker, class_name: 'Ticker'
  belongs_to :flex_3_ticker, class_name: 'Ticker'
  belongs_to :flex_4_ticker, class_name: 'Ticker'

  validates :user_id, uniqueness: { scope: :match_id }

  validates :technology_ticker_id, inclusion: { in: Ticker.technology.ids, allow_nil: true }
  validates :financial_services_ticker_id, inclusion: { in: Ticker.financial_services.ids, allow_nil: true }
  validates :telecommunications_ticker_id, inclusion: { in: Ticker.telecommunications.ids, allow_nil: true }
  validates :energy_ticker_id, inclusion: { in: Ticker.energy.ids, allow_nil: true }
  validates :healthcare_ticker_id, inclusion: { in: Ticker.healthcare.ids, allow_nil: true }

  def editable?
    !match.started?
  end

  def <=>(other)
    score <=> other.score
  end

  def score
    @score ||= rand(10)
  end

  def ticker_ids
    [technology_ticker_id, 
      financial_services_ticker_id, 
      telecommunications_ticker_id, 
      energy_ticker_id, 
      healthcare_ticker_id, 
      flex_1_ticker_id, 
      flex_2_ticker_id, 
      flex_3_ticker_id, 
      flex_4_ticker_id
    ].compact
  end
end
