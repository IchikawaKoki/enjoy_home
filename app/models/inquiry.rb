class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message
  
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}
  validates :message, :presence => {:message => 'メールアドレスを入力してください'}
end