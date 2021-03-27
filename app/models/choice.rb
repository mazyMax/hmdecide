class Choice < ApplicationRecord
    belongs_to :user
    belongs_to :post, optional: true
    has_one_attached :images
    acts_as_votable
    
    validate :image_presence
      def image_presence
          errors.add(:images, "can't be blank") unless images.attached?
      end
end
