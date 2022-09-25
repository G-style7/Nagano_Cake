class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: {no_make: 0, make_wait: 1, making: 2, make_fin: 3}
end
