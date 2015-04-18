class PagesController < ApplicationController
	def chart
		@chart_data = XigniteClient.new.get_historical_quotes("AAPL", "2015-01-01", "2015-04-01").map do |date|
			{
				"Date"=>date.date,
				"Open"=>date.open,
				"Close"=>date.close,
				"High"=>date.high,
				"Low"=>date.low,
				"Adj_Close"=>date.adj_close,
				"Volume"=>date.volume


			}
		end


	end
end
