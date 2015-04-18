require 'faraday'
require 'faraday_middleware'

class XigniteClient

  def get_delayed_quote(symbol)
    api_paramaters = {
      'IdentifierType' => 'Symbol',
      'Identifier' => symbol,
      '_Token' => token
    }

    raw_response = conn.get(xignite_api_url('xGlobalQuotes.json/GetGlobalDelayedQuote'), api_paramaters).body

    p raw_response
  end

  def get_historical_quotes(symbol, start_date, end_date)

    # { "Volume": 88994274.0, "Adj_Close": 15.79, "High": 15.75, "Low": 15.5, "Date": "2015-04-17", "Close": 15.79, "Open": 15.71}
    api_paramaters = {
      'IdentifierType' => 'Symbol',
      'Identifier' => symbol,
      'AdjustmentMethod' => 'SplitAndCashDividend',
      'StartDate' => start_date,
      'EndDate' => end_date,
      '_Token' => token
    }

    response = conn.get(xignite_api_url('xGlobalHistorical.json/GetGlobalHistoricalQuotesRange'), api_paramaters).body['GlobalQuotes']
    response.map do |tuple|
      HistoricQuote.new(date: Date.strptime(tuple["Date"], '%m/%d/%Y'),
                        open: tuple['Open'],
                        high: tuple['High'],
                        low: tuple['Low'],
                        close: tuple['LastClose'],
                        volume: tuple['Volume'],
                        adj_close: tuple['LastClose'])
    end
  end


  def all_north_america_companies
    north_american_companies('A', 'ZZZZ')
  end

  def north_american_companies(start_symbol, end_symbol)
    params = {
      "_Token" => token,
      "StartSymbol" => start_symbol,
      "EndSymbol" => end_symbol,
      "MarketIdentificationCode" => "XNAS"
    }
    response = conn.get("http://financials.xignite.com/xFinancials.json/ListCompanies", params).body['Companies']
    response.map do |tuple|
      XigniteTicker.new(
        company_name: tuple["CompanyName"],
        symbol: tuple["Symbol"],
        cusip: tuple["CUSIP"],
        isin: tuple["ISIN"],
        valoren: tuple["Valoren"],
        market: tuple["Market"])
    end
  end

  def nasdaq_ticker_detail(symbol)
    today = Time.now.strftime('%m/%d/%Y')
    params = {
      "_Token" => token,
      "IdentifierType" => "Symbol",
      "Identifier" => symbol,
      "StartDate" => today,
      "EndDate" => today
    }

    response = conn.get('http://globalmaster.xignite.com/xglobalmaster.json/GetMasterByIdentifier', params).body
    nasdaq_item = response.select { |item| item["ExchangeName"] == "NASDAQ" }.first
    XignteTickerDetail.new(
      symbol: nasdaq_item["Symbol"],
      sector: nasdaq_item["Sector"],
      industry: nasdaq_item["Industry"]
    ) if nasdaq_item
  end

  def all_sectors
    params = {
      "_Token" => token,
    }

    response = conn.get('http://fundamentals.xignite.com/xFundamentals.json/ListSectorsAndIndustries', params).body['Sectors']
    response.map do |sector|
      XigniteSector.new(
        code: sector["Code"],
        name: sector["Name"],
        children: sector["IndustryGroups"].map do |group|
          XigniteSector.new(
            code: group["Code"],
            name: group["Name"],
            children: group["Industries"].map do |industry|
              XigniteSector.new(
                code: industry["Code"],
                name: industry["Name"],
                children: [])
            end)
        end)
    end
  end


  private

  def token
    "6E10075F14A6447E94C8700F8CF7116A"
  end

  def xignite_api_url(resource)
    "http://www.xignite.com/#{resource}"
  end

  def conn
    @conn ||= Faraday.new do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter Faraday.default_adapter
      faraday.options[:timeout] = 7
      faraday.options[:open_timeout] = 2
    end
  end
end
