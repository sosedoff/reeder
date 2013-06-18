class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  validates :name,     presence: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, if: :new_record?
  
  def generate_api_token(len=10)
    self.api_token = SecureRandom.hex(len)
  end
end