class AccessToken < ApplicationRecord
  validates_presence_of :token, message: 'can not be blank'
  validates_uniqueness_of :token, message: "should be uniqe"

  belongs_to :user

  after_initialize :generate_token

  private

  def generate_token
    loop do
      break if token.present? && !AccessToken.exists?(token: token)
      self.token = SecureRandom.hex(10)
    end
  end

end
