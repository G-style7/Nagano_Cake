class Genre < ApplicationRecord

  has_many :items, dependent: :destroy
end

#バリデーション　（モデル、view、コントローラーに記述）