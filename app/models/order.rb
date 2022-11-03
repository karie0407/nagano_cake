class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details,dependent: :destroy

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting:0,making:1,payment_confirmation:2,shipping_preparation:3,shipped:4}
  def total_amount
    self.order_details.all.sum(:amount)
  end
  def subtotal
     item.with_tax_price * amount
  end
end
