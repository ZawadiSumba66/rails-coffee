class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_format_of :email, {with: Devise::email_regexp, message: 'must be a valid email address'}
  validates :email, presence: true, uniqueness: true
end
