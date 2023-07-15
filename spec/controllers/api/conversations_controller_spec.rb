RSpec.describe Api::ConversationsController, type: :controller do
  describe 'GET index' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns 200 when session is available' do
      conversation = create(:conversation, session: session)

      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns 401 when token is not passed', skip_before: true do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 when session does not exist', skip_before: true do
      mockup_session = build(:session)
      mockup_session.id = 0
      authenticate_request(mockup_session)
      get :index
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns correct data' do
      create(:conversation, session: session)
      create(:conversation, session: session)

      get :index

      parsed_body = JSON.parse(response.body)
      expect(parsed_body).not_to be_empty
      expect(parsed_body.count).to eq(2)
    end
  end

  describe 'GET show' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns 200 when session is available' do
      conversation = create(:conversation, session: session)

      get :show, params: { id: conversation.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns 401 when session is not available', skip_before: true do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns the correct session' do
      conversation = create(:conversation, session: session)

      get :show, params: { id: conversation.id }

      parsed_body = JSON.parse(response.body)
      expect(parsed_body).not_to be_empty
      expect(parsed_body['id']).to eq(conversation.id)
    end
  end

  describe 'POST create' do
    let(:session) { create(:session) }
    let(:candidate_profile) { create(:profile) }
    let(:target_profile) { create(:profile) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'fails when authentication is not available', skip_before: true do
      params = { candidate_profile_id: candidate_profile.id, target_profile_id: target_profile.id }
      post :create, params: params
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns the conversation data when creation is successful' do
      params = { candidate_profile_id: candidate_profile.id, target_profile_id: target_profile.id }
      
      post :create, params: params

      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(parsed_body).not_to be_empty
    end
  end
end
