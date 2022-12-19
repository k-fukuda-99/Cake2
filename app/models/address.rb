class Address < ApplicationRecord
  VALID_POSTCODE_REGEX = /\A\d{7}$\z/

  belongs_to :customer

  def shipping_postcode_and_address_and_name
    "〒#{self.shipping_postcode}  #{self.shipping_address}  #{self.shipping_name}"
  end

  validates :shipping_postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :shipping_address, presence: true, length: { in: 1..48 }
  validates :shipping_name, presence: true, length: { in: 1..32 }

end
