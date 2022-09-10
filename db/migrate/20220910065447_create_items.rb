class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id ,null: false
      t.string :name ,null: false
      t.text :introduction ,null: false
      t.integer :price ,null: false
      
      t.boolean :is_active ,default: false ,null: false  
      #この追加要領で良いのか？

      t.timestamps
    end
  end
end
