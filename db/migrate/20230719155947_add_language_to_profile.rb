class AddLanguageToProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false
      t.timestamps

      t.index :name, name: 'unique_name_for_language', unique: true
    end

    add_reference :profiles, :language, null: false, foreign_key: true
  end
end
