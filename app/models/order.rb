class Order < ApplicationRecord
# 郵便番号（ハイフンなし7桁）
 VALID_POSTCODE_REGEX = /\A\d{7}\z/

  validates :total_payment, presence: true
  validates :payment_method, presence: true
  validates :shipping_cost, presence: true
  validates :address, length: { in: 1..48 }
  validates :postal_code, format: { with: VALID_POSTCODE_REGEX }
  validates :name, length: { in: 1..32 }
  validates :status, presence: true

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}


  #@order.valid?を使用したいための、仮情報入力
  #任意のタイミングでオブジェクトのバリデーション（検証）を行うメソッド。
  def temporary_information_input(current_customer_id)
    self.customer_id = current_customer_id
    self.shipping_cost = 800
    self.total_payment = 1
  end

  def order_in_postcode_address_name(postcode, address, name)
    self.postal_code = postcode
    self.address = address
    self.name = name
  end

end
