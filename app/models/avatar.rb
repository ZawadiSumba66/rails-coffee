class Avatar < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    def self.avatar_url(avatar)
        if avatar.attached?
          avatar.blob.url
        end
      end
end