class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :personal_name, null: false
      t.string :email, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
