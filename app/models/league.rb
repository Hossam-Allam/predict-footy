class League < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :league_memberships, dependent: :destroy
  has_many :users, through: :league_memberships

  validates :name, presence: true
  validates :unique_code, presence: true, uniqueness: true

  before_validation :generate_unique_code, on: :create

  private

  def generate_unique_code
    # Generates a 6-character code, e.g., "3F7A2C"
    self.unique_code ||= loop do
      code = SecureRandom.hex(3).upcase
      break code unless League.exists?(unique_code: code)
    end
  end
end
