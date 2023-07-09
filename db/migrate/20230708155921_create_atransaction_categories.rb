# frozen_string_literal: true

class CreateAtransactionCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :atransaction_categories do |t|
      t.integer :atransaction_id
      t.integer :category_id

      t.timestamps
    end

    add_foreign_key :atransaction_categories, :atransactions, column: :atransaction_id
    add_foreign_key :atransaction_categories, :categories, column: :category_id

    add_index :atransaction_categories, :atransaction_id
    add_index :atransaction_categories, :category_id
  end
end
