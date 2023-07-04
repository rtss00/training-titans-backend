ActiveAdmin.register Session do
  include JsonWebToken
  
  show do
    h3 session.id
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :session_token
    end
    body "Session tokens are available for 90 days after updating the session."
  end

  index do
    column :id
    column :created_at
  end
end
