class Chat < ApplicationRecord
  after_create_commit { ChatBroadcastJob.perform_later self }

  belongs_to :user
  belongs_to :room

  has_many :notifications, dependent: :destroy

  def create_notification_chat!(room_id, current_user)
    another_entries = UserRoom.where(room_id: room_id).where.not(user_id: current_user.id)
    theid = another_entries.find_by(room_id: room_id)
    notification = current_user.active_notifications.new(
      chat_id: id,
      room_id: room_id,
      visited_id: theid.user_id,
      action: "dm"
    )
    if notification.visitor_id == notification.visited_id
       notification.checked = true
    end
    notification.save if notification.valid?
  end
end
