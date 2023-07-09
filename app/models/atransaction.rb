class Atransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :atransaction_categories, dependent: :destroy
  has_many :categories, through: :atransaction_categories

  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :author_id, presence: true
end
