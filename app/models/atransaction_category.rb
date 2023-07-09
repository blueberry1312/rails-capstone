class AtransactionCategory < ApplicationRecord
  belongs_to :atransaction
  belongs_to :category

  validates :atransaction_id, presence: true
  validates :category_id, presence: true
end
