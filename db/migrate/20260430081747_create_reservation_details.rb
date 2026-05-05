class CreateReservationDetails < ActiveRecord::Migration[8.1]
  def change
    # PostgreSQL ネイティブ enum を先に作成
    create_enum :person_type, %w[adult student child infant]
    create_table :reservation_details do |t|
      t.bigint  :reservation_id,   null: false
      t.enum    :person_type, enum_type: :person_type, null: false
      t.integer :number_of_people, null: false
      t.integer :price,            null: false
      t.integer :subtotal,         null: false
      t.timestamps
    end
    add_foreign_key :reservation_details, :reservations,
                    column: :reservation_id
    add_index :reservation_details, [:reservation_id, :person_type],
              unique: true,
              name: "idx_reservation_details_on_reservation_and_type"
  end
end
