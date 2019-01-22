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
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    end 
    user = current_user
    @cards = Card.where("date > ? AND date < ?", start_date, end_date)
    
    render json: @cards, status: :created
  end 

  def create_game_timeline(start_date, end_date)
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)

    if Card.all.length == 0
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    elsif start_date < earliest_record || end_date > latest_record 
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    end 
  end 

  def index
    games = Game.all
    render json: games
  end

  def create
    start_date = game_params[:start_date].to_i
    end_date = game_params[:end_date].to_i
    create_game_timeline(start_date, end_date)
    cards = Card.where("date > ? AND date < ?", start_date, end_date)

    game = Game.new(game_params)
    game.cards = cards
    if game.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        GameSerializer.new(game)
      ).serializable_hash
      ActionCable.server.broadcast 'games_channel', serialized_data
      head :ok
    end
  end

  def game_params
    params.require(:game).permit(:start_date, :end_date, :admin)
  end
end
