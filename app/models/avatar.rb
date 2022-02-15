class Avatar < ApplicationRecord
    belongs_to :user
    def self.avatar_url(avatar)
        if avatar.attached?
          avatar.blob.url
        end
      end
end