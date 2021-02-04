class Post < ApplicationRecord

  attachment :image

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :favorites, dependent: :destroy

  has_many :comments, dependent: :destroy

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
end
