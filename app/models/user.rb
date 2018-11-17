class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  
  has_many :goals
  
  attr_reader :password
  after_initialize :ensure_session_token
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def self.find_by_credentials(uname, pword)
    user = User.find_by(username: uname)
    user && user.isPassword?(pword) ? user : nil
  end
  
  def password=(pword)
    @password = pword
    self.password_digest = BCrypt::Password.create(pword)
  end
  
  def isPassword?(pword)
    BCrypt::Password.new(self.password_digest).is_password?(pword)
  end
  
end
