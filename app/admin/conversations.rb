ActiveAdmin.register Conversation do
  permit_params :session_id, :candidate_profile_id, :target_profile_id

  show do
    h3 conversation.id
    attributes_table do
      row :id
      row :candidate_profile
      row :target_profile
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    column :id
    column :candidate_profile
    column :target_profile
    column :created_at
    actions
  end

  form title: 'Conversation' do |f|
    f.semantic_errors

    inputs 'Details' do
      input :session, member_label: :id
      input :candidate_profile, member_label: :id
      input :target_profile, member_label: :id
    end

    actions
  end
end
