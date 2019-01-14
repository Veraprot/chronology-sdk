require 'pry'

class Api::V1::GamesController < ApplicationController
  def create_timeline 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)
    # if game_params[:startDate].to_i < earliest_record || game_params[:endDate].to_i > latest_record 
      # HistoryAPI.process_request(game_params[:startDate], game_params[:endDate])
    # end 

    @cards = Card.where("date > ? AND date < ?", Date.parse(game_params[:startDate]), Date.parse(game_params[:endDate]))
    puts @cards.length
    # puts @cards.first['date']
    # byebug
    render json: @cards, status: :created
  end 

  def game_params
    params.require(:game).permit(:startDate, :endDate)
  end
end
