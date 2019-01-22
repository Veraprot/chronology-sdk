class ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :num_of_answers, :num_of_moves, :score, :user, :game
  def user
    {
      user_id: self.object.user.id, 
     user_name: self.object.user.username
    }
  end 

  def game 
    { start: self.object.game.start_date, 
      end: self.object.game.end_date,
    }
  end
end
