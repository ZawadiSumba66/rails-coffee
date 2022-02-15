class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook] 

  validates_format_of :email, {with: Devise::email_regexp, message: 'must be a valid email address'}
  validates :email, presence: true, uniqueness: true

  has_one :avatar
  
  def self.signin_or_create_from_provider(provider_data)
      where(provider: provider_data[:provider], uid: provider_data[:uid]).first_or_create do |user|
        user.email = provider_data[:info][:email]
        user.password = Devise.friendly_token[0, 20]
        user.skip_confirmation! # when you signup a new user, you can decide to skip confirmation
      end
    end
end
