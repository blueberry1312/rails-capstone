# frozen_string_literal: true

class CreateAtransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :atransactions do |t|
      t.integer :author_id
      t.string :name
      t.float :amount

      t.timestamps
    end

    add_foreign_key :atransactions, :users, column: :author_id
    add_index :atransactions, :author_id
  end
end
