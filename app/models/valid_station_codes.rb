class ValidStationCodes < BartApiWrapper
  def get_valid_station_codes
    result = self.class.get('/stn.aspx', { query: { cmd: 'stns', key: BART_PUBLIC_API_KEY } })
    result['root']['stations']['station'].map do |station|
      {
        name: station['name'],
        station_code: station['abbr']
      }
    end
  end
end
