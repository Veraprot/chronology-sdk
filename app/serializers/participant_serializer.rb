class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :user_id, :num_of_answers, :num_of_moves
end
