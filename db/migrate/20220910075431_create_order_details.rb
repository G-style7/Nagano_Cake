class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
       t.integer :order_id , null: false #注文ID
       t.integer :item_id , null: false #商品ID
       t.integer :price , null: false #購入時価格（税込）
       t.integer :making_status , null: false #製作ステータス（enumで管理）
       t.integer :amount , null: false #数量

      t.timestamps
    end
  end
end
