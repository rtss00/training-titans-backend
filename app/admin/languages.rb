ActiveAdmin.register Language do
  permit_params :name, :created_at, :updated_at
  include JsonWebToken
  
  show do
    attributes_table do
      row :id
      row :name
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
