require 'faraday'
require 'faraday_middleware'

class PsychSignalClient

  def get_current_sentiment(symbol)

    api_paramaters = {
        'symbols' => symbol,
        'sources' => 'stocktwits',
        'update' => '1d',
        'api_key' => api_key
    }

    response = conn.get(psychsignal_api_url('sentiments/'), api_paramaters).body.first
    if response
      Sentiment.new(
        bullish_intensity: response['bullish_intensity'],
        bearish_intensity: response['bearish_intensity'],
        bull_minus_bear:  response['bull_minus_bear'],
        bull_scored_messages:  response['bull_scored_messages'],
        bear_scored_messages:  response['bear_scored_messages'],
        bull_bear_msg_ratio:  response['bull_bear_msg_ratio'],
        total_scanned_messages: response['total_scanned_messages']
      )
    else
      Sentiment.new
    end
  end



  private

  def api_key
    "fth15d7ea05f5e9482e48d94ae3d08e9ff512"
  end

  def psychsignal_api_url(resource)
    "https://api.psychsignal.com/v2/#{resource}"
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

# https://api.psychsignal.com/v2/sentiments?api_key=fth15d7ea05f5e9482e48d94ae3d08e9ff512&update=1d&sources=stocktwits,twitter_withretweets&symbols=MARKET