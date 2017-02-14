class BartApiWrapper
  include HTTParty
  base_uri 'http://api.bart.gov/api'

  # source: http://www.bart.gov/schedules/developers/api
  BART_PUBLIC_API_KEY = 'MW9S-E7SL-26DU-VV8V'
end
