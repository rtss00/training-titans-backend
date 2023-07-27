ActiveAdmin.register Conversation do
  permit_params :session_id, 
                :candidate_profile_id, 
                :target_profile_id, 
                messages_attributes: [:id, :actor, :content, :_destroy]

  show do
    h3 conversation.id
    attributes_table do
      row :id
      row :candidate_profile
      row :target_profile
      row :created_at
      row :updated_at

      panel 'Messages' do
        table_for conversation.messages do |t|
          column :actor
          column :content
          column :created_at
        end
      end
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

    inputs 'Messages' do
      f.has_many :messages do |message|
        message.input :actor
        message.input :content
        message.input :_destroy, as: :boolean, required: false, label: 'Remove'
      end
    end

    actions
  end
end
