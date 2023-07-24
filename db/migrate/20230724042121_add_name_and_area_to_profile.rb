class AddNameAndAreaToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :area, :string
  end
end
