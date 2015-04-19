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
        "Date" => date.date,
        "Open" => date.open,
        "Close" => date.close,
        "High" => date.high,
        "Low" => date.low,
        "Adj_Close" => date.adj_close,
        "Volume" => date.volume
      }
    end.reverse
  end

  def sentiment
    PsychSignalClient.new.get_current_sentiment(symbol)
  end

  def latest_price
    bats_price = XigniteClient.new.get_bats_price(self.symbol)
    bats_price.bid == 0 ? bats_price.close : bats_price.bid
  end

  def latest_change
    XigniteClient.new.get_bats_price(self.symbol).change
  end

  def closing_price_on(as_of)
    XigniteClient.new.get_historical_quotes(self.symbol, as_of, as_of).first.adj_close
  end

  def opening_price_on(as_of)
    XigniteClient.new.get_historical_quotes(self.symbol, as_of, as_of).first.open
  end

  def change_on(as_of)
    XigniteClient.new.get_historical_quotes(self.symbol, as_of, as_of).first.change
  end

end
