class Instrument < ApplicationRecord
    before_destroy :not_referenced_by_any_line_item
    mount_uploader :image, ImageUploader
    serialize :image, JSON
    belongs_to :user, optional:true
    has_many :line_items

    #validates :title, :brand, :price, :model, presence:true
    validates :description, length: {maximum: 1000, too_long: " %{count} characters is too long"}
    validates :title, length: {maximum: 140, too_long: " %{count} characters is too long"}
    validates :price, length:{maximum: 7}


    BRAND = %w{ Gibson Fender PRS G&L Rickenbacker Ibanez ESP Jackson}
    COLOR = %w{White Black Grey Yellow Seafoam Blue CLear Navy}
    CONDITION = %w{New Excellent Mint Used Fair Poor}

    private

    def not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, "line items present")
            throw :abort
        end
    end

end
