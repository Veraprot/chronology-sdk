require 'pry'

class Api::V1::GamesController < ApplicationController
  def create_timeline 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)

    if game_params[:startDate] < earliest_record || game_params[:endDate] > latest_record 
      HistoryAPI.process_request(game_params[:startDate], game_params[:endDate])
    end 

    @cards = Card.where("date > ? AND date < ?", game_params[:startDate], game_params[:endDate])
    render json: @cards, status: :created
  end 

  def game_params
    params.require(:game).permit(:startDate, :endDate)
  end
end
