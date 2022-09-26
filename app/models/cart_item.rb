class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :item_id, :amount, presence: true
  validates :amount, numericality:{ only_integer: true }

  def sum_price # 税込価格を算出したメソッドを定義して呼び出す taxin_priceは item.rb（税込価格)に定義
      item.with_tax_price * amount
  end

end
