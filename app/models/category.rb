class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :transaction_categories, dependent: :destroy
  has_many :transactions, through: :transaction_categories

  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :icon, presence: true
  validates :author_id, presence: true
end
