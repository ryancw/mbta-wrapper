require 'json' #subway
require 'net/http'
require 'rexml/document' #bus

class Subway
  def initialize(line)
    @line = line
  end

  def get_and_parse_json
    resp = Net::HTTP.get_response(URI.parse("http://developer.mbta.com/lib/rthr/#{@line}.json"))
    data = JSON.parse(resp.body)
    ready = data['TripList']
  end

  # Number of current active trains
  def active_trains
    data = get_and_parse_json
    data['Trips'].length
  end

  # Time until next train at station
  def time_until(station)
    data = get_and_parse_json
    time = 0
    data['Trips'].each do |trip|
    end
  end

  # 
  def upcoming(number = 10)
    data = get_and_parse_json
    data['Trips'].each do |trip|
      first_prediction = trip['Predictions'].first
      stop = first_prediction['Stop']
      time = (sec = first_prediction['Seconds'].to_i) < 60 ? sec : (sec / 60).round
      if sec < 60
        puts "A #{@line} line train will arrive at #{stop} in #{time} seconds"
      else
        puts "A #{@line} line train will arrive at #{stop} in #{time} minutes"
      end
    end
  end

  def next_stops
  end

end

class CommuterRail
  def initialize(line)
    @line_name = line
    @line = COMMUTER_RAIL_LINES[line.to_s]
    if @line.nil?
      puts 'Error: line name incorrect'
    end
  end

  COMMUTER_RAIL_LINES = {'Greenbush' => '1', 'Kingston' => '2', 'Kingston/Plymouth' => '2', 'Plymouth' => '2', 'Middleborough/Lakeville' => '3', 'Middleborough' => '3', 'Lakeville' => '3', 'Fairmount' => '4', 'Providence/Stoughton' => '5', 'Providence' => '5', 'Stoughton' => '5', 'Franklin' => '6', 'Needham' => '7', 'Framingham/Worcester' => '8', 'Framingham' => '8', 'Worcester' => '8', 'Fitchburg' => '9', 'Lowell' => '10', 'Haverhill' => '11', 'Newburyport/Rockport' => '2', 'Newburyport' => '2', 'Rockport' => '2'}


  def get_and_parse_json
    resp = Net::HTTP.get_response(URI.parse("http://developer.mbta.com/lib/RTCR/RailLine_#{@line}.json"))
    data = JSON.parse(resp.body)
  end

  # Total active trains in all lines
  def self.total_active_trains
  end

  # Active train for given lines
  def active_trains
  end
end
