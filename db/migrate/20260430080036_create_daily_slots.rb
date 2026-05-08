class CreateDailySlots < ActiveRecord::Migration[8.1]
  def change
    create_enum :daily_slot_status, %w[open closed_regular closed_temp suspended]

    create_table :daily_slots, primary_key: :applicable_date, id: :date, force: :cascade do |t|
      t.enum    :status,       null: false, default: "open", enum_type: :daily_slot_status
      t.integer :max_capacity
      t.bigint  :price_id

      t.timestamps
    end

    add_foreign_key :daily_slots, :prices
    add_index :daily_slots, :price_id
  end
end