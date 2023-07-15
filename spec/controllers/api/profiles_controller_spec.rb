RSpec.describe Api::ProfilesController, type: :controller do  
  describe 'GET index' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns correct data' do
      create(:profile)
      create(:profile)

      get :index

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_body).not_to be_empty
      expect(parsed_body['profiles'].count).to eq(2)
    end
  end

  describe 'GET show' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns correct data' do
      profile = create(:profile)

      get :show, params: { id: profile.id }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_body).not_to be_empty
    end
  end
end
