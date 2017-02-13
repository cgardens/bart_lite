class Arrival
  include HTTParty
  base_uri 'http://api.bart.gov/api/etd.aspx'

  BART_PUBLIC_API_KEY = 'MW9S-E7SL-26DU-VV8V'
  # source: http://www.bart.gov/schedules/developers/api
  NORTH_BERKELEY_STATION = 'nbrk' # North Berkeley
  MONTGOMERY_BART_STATION = 'mont'
  NORTH = 'n'
  SOUTH = 's'

  def initialize(station, direction)
    @options = { query: {
      key: BART_PUBLIC_API_KEY,
      orig: station,
      dir: direction,
      cmd: 'etd',
    } }
  end

  def self.go_to_work
    Arrival.new(NORTH_BERKELEY_STATION, SOUTH).get_arrivals
  end

  def self.go_home
    Arrival.new(MONTGOMERY_BART_STATION, NORTH).get_arrivals
  end

  def get_arrivals
    bart_api_response = self.class.get('', @options)
    etd_by_line = bart_api_response['root']['station']['etd']
    arrivals_estimates = []

    # normal result.
    # if there are only results for one line, the api returns one of the objects from the array, but not the array itself.
    if !etd_by_line.is_a? Array
      etd_by_line = [etd_by_line]
    end

    etd_by_line.each do |line|
      estimates = line['estimate']

      # normal result.
      # if there are only results for one estimate, the api returns one of the objects from the array, but not the array itself.
      if !estimates.is_a? Array
        estimates = [estimates]
      end

      estimates.each do |estimate|
        arrivals_estimates.push({
          destination: line['destination'],
          eta_min: estimate['minutes'],
          length: estimate['length'],
          direction: estimate['direction'],
          platform: estimate['platform']
        })
      end
    end
    arrivals_estimates.sort_by { |estimate| estimate[:eta_min] }

  end

  def to_commute_useful_json

  end
end
