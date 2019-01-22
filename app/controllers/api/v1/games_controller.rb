require 'pry'

class Api::V1::GamesController < ApplicationController
  def index
    games = Game.all
    render json: games
  end
  #single player, take out once multiplayer works 
  def create_timeline(start_date, end_date) 
    earliest_record = Card.minimum(:date)
    latest_record = Card.maximum(:date)
    if Card.all.length == 0 ||
      start_date < earliest_record ||
      end_date > latest_record ||
      Card.where("date = '#{start_date}'").length == 0
      HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
    end 
  end 

  def create
    start_date = game_params[:start_date].to_i
    end_date = game_params[:end_date].to_i

    create_timeline(start_date, end_date)
    game = Game.new(game_params)
    game.cards = Card.where("date > ? AND date < ?", start_date, end_date)
    if game.save
      Participant.create(score: 0, game_id: game.id, user_id: current_user.id, num_of_answers: 0, num_of_moves: 0)
      render json: game, status: :created
    end 
  end 


  # # for multiplayer
  # def create_game_timeline(start_date, end_date)
  #   earliest_record = Card.minimum(:date)
  #   latest_record = Card.maximum(:date)

  #   if Card.all.length == 0
  #     HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
  #   elsif start_date < earliest_record || end_date > latest_record 
  #     HistoryAPI.process_request(game_params[:start_date], game_params[:end_date]) 
  #   end 
  # end 

  # #for multiplayer
  # def create
  #   start_date = game_params[:start_date].to_i
  #   end_date = game_params[:end_date].to_i
  #   create_game_timeline(start_date, end_date)
  #   cards = Card.where("date > ? AND date < ?", start_date, end_date)

  #   game = Game.new(game_params)
  #   game.cards = cards
  #   if game.save
  #     serialized_data = ActiveModelSerializers::Adapter::Json.new(
  #       GameSerializer.new(game)
  #     ).serializable_hash
  #     ActionCable.server.broadcast 'games_channel', serialized_data
  #     head :ok
  #   end
  # end

  def game_params
    params.require(:game).permit(:start_date, :end_date, :admin)
  end
end
