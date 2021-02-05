class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  has_many :notifications, dependent: :destroy
end
