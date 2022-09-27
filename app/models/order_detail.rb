class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {no_make: 0, make_wait: 1, making: 2, make_fin: 3}

  def sum_price # 税込価格を算出したメソッドを定義して呼び出す taxin_priceは item.rb（税込価格)に定義
      (price * 1.1).floor * amount
  end
end
