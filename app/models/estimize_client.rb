require 'faraday'
require 'faraday_middleware'

class EstimizeClient

  def current_wall_street_eps_estimate(symbol)

    # get estimates for next quarter (hardcoded for now)
    response = conn.get(estimize_api_url("companies/#{symbol}/releases/2015/2"), api_params, api_headers)

    response_body = response.body["consensus_eps_estimate"] if response.body
    response_body || 0

  end

  def current_crowdsourced_eps_estimate(symbol)

    # get estimates for next quarter (hardcoded for now)
    response = conn.get(estimize_api_url("companies/#{symbol}/estimates/2015/2"), api_params, api_headers).body

    return 0 if response.nil? || response.size == 0

    response.map { |estimate| estimate['eps'] }.reduce(:+) / response.size

  end


  def ratio(symbol)

    crowdsourced = current_crowdsourced_eps_estimate(symbol)
    street = current_wall_street_eps_estimate(symbol)

    return 0 if street == 0

    ((crowdsourced - street) / street).round(2)

  end
  private

  def formatted_start
    14.days.ago.strftime("%Y-%m-%d")
  end

  def api_params
    {}
  end

  def api_headers
    {'X-Estimize-Key' => api_key}
  end

  def api_key
    "38704631c5b84c02a4bb900e"
  end

  def estimize_api_url(resource)
    "http://api.estimize.com/#{resource}"
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
