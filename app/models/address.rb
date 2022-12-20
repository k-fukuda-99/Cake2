class Address < ApplicationRecord
  VALID_POSTCODE_REGEX = /\A\d{7}$\z/

  belongs_to :customer

  def postal_codecode_and_address_and_name
    "〒#{self.postal_code}  #{self.address}  #{self.name}"
  end

  validates :postal_code, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :address, presence: true, length: { in: 1..48 }
  validates :name, presence: true, length: { in: 1..32 }

end
