class CreateTransactionCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_categories do |t|
      t.integer :transaction_id
      t.integer :category_id

      t.timestamps
    end

    add_foreign_key :transaction_categories, :transactions, column: :transaction_id
    add_foreign_key :transaction_categories, :categories, column: :category_id

    add_index :transaction_categories, :transaction_id
    add_index :transaction_categories, :category_id
  end
end