class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :num_of_answers, :num_of_moves, :user
  def user
    {
      user_id: self.object.user.id, 
     user_name: self.object.user.username
    }
  end 
end
