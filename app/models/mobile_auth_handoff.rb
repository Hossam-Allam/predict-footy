class MobileAuthHandoff < ApplicationRecord
  LIFETIME = 5.minutes

  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true

  attr_accessor :raw_code

  def self.issue_for!(user)
    code = SecureRandom.urlsafe_base64(32)
    create!(
      user: user,
      token_digest: digest(code),
      expires_at: LIFETIME.from_now
    ).tap { |handoff| handoff.raw_code = code }
  end

  def self.consume(code)
    return if code.blank?

    transaction do
      handoff = lock.find_by(token_digest: digest(code))
      next unless handoff

      user = handoff.user if handoff.expires_at.future?
      handoff.destroy!
      user
    end
  end

  def self.digest(code)
    OpenSSL::Digest::SHA256.hexdigest(code)
  end

  private_class_method :digest
end
