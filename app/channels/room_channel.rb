class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat = Chat.create!(message: data['chat'], user_id: current_user.id, room_id: params['room'])
    chat.create_notification_chat!(params['room'], current_user)
  end
end
