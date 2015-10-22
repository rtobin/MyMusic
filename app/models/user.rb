class User < ActiveRecord::Base
  INVALID_PASSWORD =<<-PSSWRD
Password must be at least 6 characters, no more than 16 characters,
and must include at least one upper case letter, one lower case letter,
and one numeric digit.
PSSWRD

  attr_reader :password
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates_format_of :password,
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,16}\z/,
    message: "Invalid password! \n #{INVALID_PASSWORD}"
  validates :password, length: { minimum: 6, maximum: 15, allow_nil: true}

  before_validation :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def is_password?(password)
    password_digest.is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end



end
