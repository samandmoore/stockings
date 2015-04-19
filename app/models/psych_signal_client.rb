require 'faraday'
require 'faraday_middleware'

class PsychSignalClient

  def get_current_sentiment(symbol)

    formatted_start = 14.days.ago.strftime("%Y-%m-%d")

    api_paramaters = {
        'symbols' => symbol,
        'sources' => 'stocktwits',
        'update' => '1d',
        'api_key' => api_key,
        'aggregate' => 'yes',
        'from' => formatted_start


    }

    response = conn.get(psychsignal_api_url('historical_sentiments/'), api_paramaters).body

    sentiments = response.map do |tuple|
      Sentiment.new(
        bullish_intensity: tuple['bullish_intensity'],
        bearish_intensity: tuple['bearish_intensity'],
        bull_minus_bear:  tuple['bull_minus_bear'],
        bull_scored_messages:  tuple['bull_scored_messages'],
        bear_scored_messages:  tuple['bear_scored_messages'],
        bull_bear_msg_ratio:  tuple['bull_bear_msg_ratio'],
        total_scanned_messages: tuple['total_scanned_messages']
      )
    end

    return 'None' if sentiments.size == 0

    avg_bullish_intensity = sentiments.map(&:bullish_intensity).reduce(:+) / sentiments.size
    total_bull_scored_messages = sentiments.map(&:bull_scored_messages).reduce(:+)
    avg_bearish_intensity = sentiments.map(&:bearish_intensity).reduce(:+) / sentiments.size
    total_bear_scored_messages = sentiments.map(&:bear_scored_messages).reduce(:+)

    return 'None' if total_bull_scored_messages + total_bear_scored_messages == 0

    weighted_intensity = ((avg_bullish_intensity * total_bull_scored_messages) - (avg_bearish_intensity * total_bear_scored_messages)) / (total_bull_scored_messages + total_bear_scored_messages)

    p weighted_intensity

    if very_bullish?(weighted_intensity.round(2))
      'Very Bullish'
    elsif bullish?(weighted_intensity.round(2))
      'Bullish'
    elsif nuetral?(weighted_intensity.round(2))
      'Neutral'
    elsif bearish?(weighted_intensity.round(2))
      'Bearish'
    elsif very_bearish?(weighted_intensity.round(2))
      'Very Bearish'
    else
      'unknown'
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

  def very_bullish?(intensity)
    intensity.between?(1.51, 4.00)
  end

  def bullish?(intensity)
    intensity.between?(0.76, 1.50)
  end

  def nuetral?(intensity)
    intensity.between?(-0.75, 0.75)
  end

  def bearish?(intensity)
    intensity.between?(-1.50, -0.76)
  end

  def very_bearish?(intensity)
    intensity.between?(-4.00, -1.51)
  end

end
