class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  attribute :shipping_cost, :integer, default: 800


  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, payment_confirmation:1, production:2, preparing_to_ship:3, sent:4 }

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

  def payment
    shipping_cost + total_payment
  end

  def full_name
    customer.last_name + customer.first_name
  end

end
