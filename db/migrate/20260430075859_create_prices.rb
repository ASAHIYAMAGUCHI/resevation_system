class CreatePrices < ActiveRecord::Migration[8.1]
  def change
    create_table :prices do |t|
      t.string :price_name, null: false
      t.integer :adult_price, null: false
      t.integer :student_price, null: false
      t.integer :child_price, null: false
      t.integer :infant_price, null: false

      t.timestamps
    end
  end
end
