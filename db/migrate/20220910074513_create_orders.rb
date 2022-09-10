class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false #会員ID
      t.string :postal_code ,null: false #配送先郵便番号
      t.string :address ,null: false #配送先住所
      t.string :name ,null: false #配送先氏名
      t.integer :shipping_cost ,null: false #送料
      t.integer :payment_method ,null: false #支払い方法（enumで管理）
      t.integer :status ,null: false #注文ステータス（enumで管理）
      t.integer :total_payment ,null: false #請求額

      t.timestamps
    end
  end
end
