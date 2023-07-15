class CreateProfileTables < ActiveRecord::Migration[7.0]
  def change
    create_table :technologies do |t|
      t.string :name, null: false
      t.text :description, null: true

      t.timestamps
    end

    create_table :profiles do |t|
      t.text :description
      t.timestamps
    end

    create_join_table :profiles, :technologies do |t|
      t.index :technology_id
      t.index :profile_id
      t.integer :seniority, null: true
    end
  end
end
