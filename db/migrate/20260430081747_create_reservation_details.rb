class CreateReservationDetails < ActiveRecord::Migration[8.1]
  def change
    # PostgreSQL ネイティブ enum を先に作成
    create_enum :person_type, %w[adult student child infant]
    create_table :reservation_details do |t|
      t.string  :res_code,         limit: 10, null: false
      t.enum    :person_type, enum_type: :person_type, null: false
      t.integer :number_of_people, null: false
      t.integer :price,            null: false
      t.integer :subtotal,         null: false
      t.timestamps
    end
    add_foreign_key :reservation_details, :reservations,
                    column: :res_code,
                    primary_key: :res_code
    add_index :reservation_details, :res_code
  end
end
