class Api::V1::ParticipantsController < ApplicationController
  def create
    participant = Participant.new(participant_params)
    game = Game.find(participant_params[:game_id])
    if participant.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ParticipantSerializer.new(participant)
      ).serializable_hash
      ParticipantsChannel.broadcast_to game, serialized_data
      head :ok
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:num_of_answers, :num_of_moves, :game_id).merge(user_id: current_user.id)
  end
end 