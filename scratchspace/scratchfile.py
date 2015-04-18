import requests
from datetime import datetime
import json


token = "6E10075F14A6447E94C8700F8CF7116A"

baseurl = "http://www.xignite.com/"

example_historical_price_call = "http://www.xignite.com/xGlobalHistorical.json/GetGlobalHistoricalQuotesRange?StartDate=2015-01-17&EndDate=2015-04-17&_Token=6E10075F14A6447E94C8700F8CF7116A&AdjustmentMethod=None&IdentifierType=Symbol&Identifier=TIP"


def get_historical_prices_by_type(symbol, start_date, end_date, token):

    # location of the api within the base url
    api_url = 'xGlobalHistorical.json/GetGlobalHistoricalQuotesRange'

    api_paramaters = {
        'IdentifierType' : 'Symbol',
        'Identifier' : symbol,
        'AdjustmentMethod' : 'SplitAndCashDividend',
        'StartDate' : start_date,
        'EndDate' : end_date,
        '_Token' : token,
    }

    # call the API
    response = requests.get(baseurl + api_url, params=api_paramaters).json()

    # return just the dict element that holds the list of responses by date
    return response['GlobalQuotes']

raw_response = get_historical_prices_by_type("BAC", "2015-01-01", "2015-04-18", token)

# stand up named tuple
cleaned_responses = []

for date in raw_response:

    test = {"Date":datetime.strptime(date['Date'], '%m/%d/%Y').strftime('%Y-%m-%d'),
            "Open":date['Open'],
            "High":date['High'],
            "Low":date['Low'],
            "Close":date['LastClose'],
            "Volume":date['Volume'],
            "Adj_Close":date['LastClose'],
            }

    cleaned_responses.append(test)


print json.dumps(cleaned_responses)

