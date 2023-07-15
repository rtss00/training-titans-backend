class AddIdToRequirements < ActiveRecord::Migration[7.0]
  def change
    add_column :requirements, :id, :primary_key
  end
end
