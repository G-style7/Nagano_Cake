class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :name, {uniqueness: true}
end

#バリデーション　（モデル、view、コントローラーに記述）