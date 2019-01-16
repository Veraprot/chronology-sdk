class GamesChannel < ApplicationCable::Channel
  def subscribed
    #stream_from expects to receive a string as an argument
    stream_from "games_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
