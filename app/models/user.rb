class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :github ]

  validates :email, uniqueness: { allow_blank: true }
  validates :name, presence: true

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    if user.new_record?
      existing_user = User.find_by(email: auth.info.email)
      if existing_user
        # Merge accounts: Link GitHub credentials to existing user
        existing_user.update!(provider: auth.provider, uid: auth.uid)
        user = existing_user
      else
        # Creating new user with GitHub data
        user.email = auth.info.email || "#{auth.uid}-github@example.com"
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name || "GitHub User #{auth.uid}" # Fallback for name
      end
    end

    user.save!
    user
  end
end
