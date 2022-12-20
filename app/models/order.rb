class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_detail
  enum payment_method: { credit_card: 0, transfer: 1 }

  def subtotal
    item.with_tax_price * amount
  end

  def full_name
    last_name + first_name
  end
end
