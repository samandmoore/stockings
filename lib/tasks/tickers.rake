namespace :tickers do

  desc "Refresh all tickers in the database"
  task refresh: [:environment] do

    all_tickers = XigniteClient.new.all_north_america_companies
    all_tickers.each { |xignite_ticker|
      Ticker.find_or_create_by(symbol: xignite_ticker.symbol) do |ticker|
        ticker.company_name = xignite_ticker.company_name
        ticker.cusip = xignite_ticker.cusip
      end
    }
  end
end
