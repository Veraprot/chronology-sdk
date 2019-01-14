require 'pry'
require 'json'
require 'net/http'
require 'active_support/core_ext/hash'

module HistoryAPI 
  def self.make_request(begin_date, end_date)
    base_url = "http://www.vizgr.org/historical-events/search.php?begin_date=#{begin_date}&end_date=#{end_date}"
    s = Net::HTTP.get_response(URI.parse(base_url)).body
    end_input = Hash.from_xml(s)
    end_input 
  end 

  def self.process_request(begin_date, end_date)
    result_hash = make_request(begin_date, end_date)
    result_hash["result"]["event"].each do |event|
      date = event["date"].split('/').join('-')
      newCard = Card.new(date: Date.parse(event["date"]), event: event["description"])
      if newCard.valid? 
        newCard.save()
      else
        puts "card already exists"
      end 
    end 
  end 
end 