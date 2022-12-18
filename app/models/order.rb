class Order < ApplicationRecord
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status_method: { waiting: 0, check: 1, production: 2, preparation: 3, sent: 4 }
end
