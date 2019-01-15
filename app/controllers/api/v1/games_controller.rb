require 'pry'

class Api::V1::GamesController < ApplicationController
  # skip_before_action :authorized, only: [:create_timeline]
  def create_timeline 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)
    start_date = game_params[:start_date].to_i
    end_date = game_params[:end_date].to_i

    if Card.all.length == 0
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    elsif start_date < earliest_record || end_date > latest_record 
      HistoryAPI.process_request(game_params[:start_date], earliest_record.to_s) 
      HistoryAPI.process_request(game_params[:end_date], latest_record.to_s) 
    end 
    user = current_user
    @game = Game.create(game_params)
    Participant.create(user_id: current_user.id, game_id: @game.id, score: 0)
    @cards = Card.where("date > ? AND date < ?", start_date, end_date)
    
    render json: @cards, status: :created
  end 

  def game_params
    params.require(:game).permit(:start_date, :end_date)
  end
end
