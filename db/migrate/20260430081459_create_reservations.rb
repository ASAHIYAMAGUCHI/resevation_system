class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    # PostgreSQL ネイティブ enum を先に作成
    create_enum :reservation_status, %w[pending confirmed visited cancelled]
    create_table :reservations, id: false, force: :cascade do |t|
      t.string  :res_code,        limit: 10, null: false, primary_key: true
      t.date    :daily_slot_date, null: false
      t.string  :personal_name,   null: false
      t.string  :email,           null: false
      t.integer :total_price,     null: false
      t.enum    :status, enum_type: :reservation_status, null: false, default: 'pending'
      t.timestamps
    end
    add_foreign_key :reservations, :daily_slots,
                    column: :daily_slot_date,
                    primary_key: :applicable_date
    add_index :reservations, :daily_slot_date
  end
end