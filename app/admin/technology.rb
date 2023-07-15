ActiveAdmin.register Technology do
  include JsonWebToken
  
  show do
    attributes_table do
      row :id
      row :description
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    column :name
    column :id
    column :created_at
    actions
  end
end
