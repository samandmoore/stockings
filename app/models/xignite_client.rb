require 'faraday'
require 'faraday_middleware'

class XIgniteClient

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

    api_paramaters = {
        'IdentifierType' => 'Symbol',
        'Identifier' => symbol,
        'AdjustmentMethod' => 'SplitAndCashDividend',
        'StartDate' => start_date,
        'EndDate' => end_date,
        '_Token' => token
    }

    raw_response = conn.get(xignite_api_url('xGlobalHistorical.json/GetGlobalHistoricalQuotesRange'), api_paramaters).body['GlobalQuotes']

    p raw_response
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
