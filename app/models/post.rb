class Post < ApplicationRecord
    belongs_to :user
    has_many :choices
    has_one_attached :image
    accepts_nested_attributes_for :choices, allow_destroy: true
    
    validate :image_presence
    
    def image_presence
        errors.add(:image, "can't be blank") unless image.attached?
    end
end
