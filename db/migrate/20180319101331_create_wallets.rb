class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.references :user, foreign_key: true
      t.integer    :balance, default: 0
      t.integer    :code, index: true, unique: true
    end
  end
end
