class Avatar < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  def self.avatar_url(avatar)
    avatar.blob.url if avatar.attached?
  end
end
