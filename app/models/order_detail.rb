class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  def subtotal
  item.with_tax_price * amount
  end
  enum making_status: {not_startable:0,waiting:1,making:2,completed:3}
end