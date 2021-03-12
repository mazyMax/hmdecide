class Choice < ApplicationRecord
    belongs_to :post
    has_one_attached :image
    acts_as_votable
    
    validate :image_presence
      def image_presence
        errors.add(:image, "can't be blank") unless image.attached?
      end
end
