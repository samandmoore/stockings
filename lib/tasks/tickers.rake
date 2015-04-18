namespace :tickers do

  desc "Refresh all tickers in the database"
  task refresh: [:environment, "sectors:refresh"] do

    all_tickers = XigniteClient.new.all_north_america_companies
    all_tickers.each do |xignite_ticker|
      unless xignite_ticker.cusip.blank?
        Ticker.find_or_create_by!(symbol: xignite_ticker.symbol) do |ticker|
          ticker.name = xignite_ticker.company_name
          ticker.cusip = xignite_ticker.cusip

          nasdaq_info = XigniteClient.new.nasdaq_ticker_detail(xignite_ticker.symbol)
          if nasdaq_info
            sector_key = nasdaq_info.sector.parameterize.underscore
            industry_key = nasdaq_info.industry.parameterize.underscore
            sector = Sector.find_by_key(sector_key)
            industry = Sector.find_by_key(industry_key)

            ticker.sector = sector
            ticker.industry = industry
          end
        end
      end
    end
  end
end
