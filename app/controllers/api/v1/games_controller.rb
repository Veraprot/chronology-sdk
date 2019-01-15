require 'pry'

class Api::V1::GamesController < ApplicationController
  # skip_before_action :authorized, only: [:create_timeline]
  @@date_range = {}
  def create_timeline 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)
    start_date = game_params[:start_date].to_i
    end_date = game_params[:end_date].to_i

    if Card.all.length == 0
      @@date_range["start"] = start_date
      @@date_range["end"] = end_date
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    elsif start_date < earliest_record || end_date > latest_record 
      HistoryAPI.process_request(game_params[:start_date], earliest_record.to_s) 
      HistoryAPI.process_request(game_params[:end_date], latest_record.to_s) 
    end 
    
    @game = Game.new(game_params)
    @cards = Card.where("date > ? AND date < ?", start_date, end_date)
    
    render json: @cards, status: :created
  end 

  def game_params
    params.require(:game).permit(:start_date, :end_date)
  end
end
