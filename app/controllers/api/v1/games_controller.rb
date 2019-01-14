require 'pry'

class Api::V1::GamesController < ApplicationController
  def create_timeline 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)
    startDate = game_params[:startDate].to_i
    endDate = game_params[:endDate].to_i

    if Card.all.length == 0
      HistoryAPI.process_request(game_params[:startDate], game_params[:endDate]) 
    end 

    if startDate < earliest_record || endDate > latest_record 
      HistoryAPI.process_request(game_params[:startDate], game_params[:endDate])
    end 

    @cards = Card.where("date > ? AND date < ?", startDate, endDate)
    
    puts @cards.length
    render json: @cards, status: :created
  end 

  def game_params
    params.require(:game).permit(:startDate, :endDate)
  end
end
