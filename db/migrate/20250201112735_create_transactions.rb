class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type, null: false
      t.date :date, null: false
      t.integer :value, null: false
      t.string :cpf, null: false
      t.string :card, null: false
      t.string :hour, null: false

      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    add_index :transactions,
              [ :transaction_type, :date, :hour, :value, :cpf, :card, :store_id ],
              unique: true,
              name:   "unique_transaction_index"
  end
end
