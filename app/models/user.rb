class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, foreign_key: :author_id, dependent: :destroy
  has_many :categories, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
end
