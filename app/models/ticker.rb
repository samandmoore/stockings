class Ticker < ActiveRecord::Base
  belongs_to :sector
  belongs_to :industry, class_name: 'Sector'

  Sector::KEYS.each do |scope_name|
    scope scope_name, -> { joins(:sector).merge(Sector.public_send(scope_name)) }
  end

  validates :name, :cusip, :symbol, presence: true
  validates :symbol, :cusip, uniqueness: true

  def chart_data
    formatted_now = Time.now.strftime("%Y-%m-%d")
    formatted_start = 3.months.ago.strftime("%Y-%m-%d")

    XigniteClient.new.get_historical_quotes(symbol, formatted_start, formatted_now).map do |date|
      {
        "Date"=>date.date,
        "Open"=>date.open,
        "Close"=>date.close,
        "High"=>date.high,
        "Low"=>date.low,
        "Adj_Close"=>date.adj_close,
        "Volume"=>date.volume
      }
    end.reverse
  end

  def sentiment
    PsychSignalClient.new.get_current_sentiment(symbol)
  end
end
