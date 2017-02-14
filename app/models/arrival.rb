class Arrival < BartApiWrapper
  # source: http://www.bart.gov/schedules/developers/api
  NORTH_BERKELEY_STATION = 'nbrk' # North Berkeley
  MONTGOMERY_BART_STATION = 'mont'
  NORTH = 'n'
  SOUTH = 's'

  def initialize(station, direction)
    @station = station
    @direction = direction

    puts BART_PUBLIC_API_KEY

    @options = { query: {
      key: BART_PUBLIC_API_KEY,
      orig: @station,
      dir: @direction,
      cmd: 'etd',
    } }
  end

  def self.get_from_station_and_direction(station, direction)
    raise "direction: #{direction} is invalid. n & y are the only valid values for direction." if direction != 'n' && direction != 's'
    Arrival.new(station, direction).get_arrivals
  end

  def self.go_to_work
    Arrival.new(NORTH_BERKELEY_STATION, SOUTH).get_arrivals
  end

  def self.go_home
    Arrival.new(MONTGOMERY_BART_STATION, NORTH).get_arrivals
  end

  def get_arrivals
    bart_api_response = self.class.get('/etd.aspx', @options)
    station_results = bart_api_response['root']['station']

    if station_results.nil?
      raise "no results found for station: #{@station}. consider hitting /valid_station_codes to check that your station code is correct."
    end

    etd_by_line = station_results['etd']
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
    arrivals_estimates.sort_by do |estimate|
      estimate[:eta_min] == 'Leaving' ? 0 : estimate[:eta_min].to_i
    end
  end
end
