class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_many :orders, through: :order_details

  has_one_attached :image
   def get_image
     unless image.attached?
       file_path = Rails.root.join('app/assets/images/no_image.jpg')
       image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     image
   end

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :is_active, inclusion: {in: [true, false]}

  # 消費税
  def taxin_price
    price*1.1
  end

end
