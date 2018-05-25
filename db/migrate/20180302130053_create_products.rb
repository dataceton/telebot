class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :order
      t.string  :name
      t.integer :price
      t.integer :weight
      t.float   :latitude
      t.float   :longitude
      t.string  :photos
      t.text    :description
      t.boolean :sold, default: false

      t.timestamps
    end
  end
end
