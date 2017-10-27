class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  attr_reader :password

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  #is this the same as valid_password?
  def is_password?(password)
    #turns password_digest from string to BCrypt object for comparisons
    pass_hash = BCrypt::Password.new(self.password_digest)
    pass_hash.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    #why not self.save! ?
    self.save
    self.session_token
  end
end
