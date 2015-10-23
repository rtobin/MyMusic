# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  counter         :integer          default(0)
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class ActiveRecord::Base
  def generate_unique_token_for_field(field)
    token = SecureRandom.base64(16)

    while self.class.exists?(field => token)
      token = SecureRandom.base64(16)
    end

    token
  end
end


class User < ActiveRecord::Base

  INVALID_PASSWORD =<<-PSSWRD
must be at least 6 characters, no more than 16 characters,
and must include at least one upper case letter, one lower case letter,
and one numeric digit.
PSSWRD

  attr_reader :password

  validates :activation_token, :email, :session_token, uniqueness: true
  validates(
      :activation_token,
      :email,
      :password_digest,
      :session_token,
      presence: true
    )

  after_initialize :ensure_session_token
  after_initialize :set_activation_token

  validate :valid_password_given, if: -> { password }

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def set_activation_token
    self.activation_token =
      generate_unique_token_for_field(:activation_token)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
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


  def valid_password_given
    unless password =~ /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,16}\z/
      errors[:password] << INVALID_PASSWORD
    end
  end

  def activate!
    self.update_attribute(:activated, true)
  end

end
