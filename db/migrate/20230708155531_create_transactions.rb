# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :author_id
      t.string :name
      t.float :amount

      t.timestamps
    end

    add_foreign_key :transactions, :users, column: :author_id
    add_index :transactions, :author_id
  end
end
