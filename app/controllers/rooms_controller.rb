class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]

  def index
    @rooms = current_user.rooms.all
    current_entries = UserRoom.where(room_id: @rooms).pluck(:user_id) << current_user.id
    @no_entries = User.where.not(id: current_entries)
    @user_room = UserRoom.new
  end

  def create
    @room = Room.create
    entry1 = UserRoom.create(room_params)
    entry2 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats.all
    another_entry = UserRoom.where(room_id: @room.id).where.not(user_id: current_user.id).pluck(:user_id)
    @opponent_user = User.find_by(id: another_entry)
  end

  private

  def room_params
    params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

  def correct_user
    @room = Room.find(params[:id])
    unless UserRoom.where(user_id: current_user.id, room_id: @room.id).exists?
      redirect_to rooms_path
    end
  end
end
