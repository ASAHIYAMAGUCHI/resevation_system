class CreateDailySlots < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_slots, primary_key: :applicable_date, id: :date, force: :cascade do |t|
      t.integer :max_capacity, null: false, default: 500
      t.bigint  :price_id,     null: false

      t.timestamps
    end

    add_foreign_key :daily_slots, :prices
    add_index :daily_slots, :price_id
  end
end