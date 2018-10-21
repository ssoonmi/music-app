# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 7 }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :notes,
    foreign_key: :user_id,
    class_name: :Note,
    dependent: :destroy

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(params)
    user = User.find_by(email: params[:email])
    return nil unless user && user.is_password?(params[:password])
    user
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    update!(session_token: self.class.generate_session_token)
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt_pw = BCrypt::Password.new(self.password_digest)
    bcrypt_pw.is_password?(password)
  end

end
