class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :message, presence: true
end