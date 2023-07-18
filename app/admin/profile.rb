ActiveAdmin.register Profile do
  include JsonWebToken

  permit_params :description, requirements_attributes: [:id, :technology_id, :seniority]
  
  show do
    attributes_table do
      row :id
      row :description
      row :created_at
      row :updated_at

      panel 'Requirements' do
        table_for profile.requirements do |t|
          column :technology do |requirement|
            technology = requirement.technology
            link_to technology.name, admin_technology_path(technology.id)
          end
          column :seniority
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :area
    column :language
    column :description
    column :created_at
    actions
  end

  form title: 'Profile' do |f|
    f.semantic_errors

    inputs 'Details' do
      input :description
      f.has_many :requirements do |requirement|
        requirement.input :technology
        requirement.input :seniority
      end
    end

    actions
  end
end
