class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :telegram_id
      t.string  :first_name
      t.string  :last_name
      t.string  :bot_command_data
      t.integer :sale
      t.boolean :super_user, default: false
      t.timestamps
    end
  end
end
