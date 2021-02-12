class Post < ApplicationRecord

  attachment :image

  validates :title, length: { maximum: 20 } 
  validates :description, presence: true

  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :favorites, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :destroy

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end
    new_tags.each do |new_tag|
      post_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << post_tag
    end
  end

  def favorited_by?(user)
    self.favorites.where(user_id: user.id).exists?
  end

  def self.search_title(word)
    Post.where(['title LIKE ?', "%#{word}%"])
  end

  def self.search_content(word)
    Post.where(['description LIKE ?', "%#{word}%"])
  end

  def create_notification_like!(current_user)
    temp = Notification.where(visitor_id: current_user.id, visited_id: user_id,  post_id: id, action: 'like')
    if temp.blank?
       notification = current_user.active_notifications.new(
       post_id: id,
       visited_id: user_id,
       action: 'like'
       )
       if notification.visitor_id == notification.visited_id
         notification.checked = true
       end
       notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.where(post_id: id).select(:user_id).distinct.pluck(:user_id)
    unless temp_ids.include?(user_id)
      temp_ids << user_id
    end
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id)
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
