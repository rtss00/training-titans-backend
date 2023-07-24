RSpec.describe Api::TechnologiesController, type: :controller do  
  describe 'GET index' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns correct data' do
      create(:technology)
      create(:technology)

      get :index

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_body).not_to be_empty
      expect(parsed_body['technologies'].count).to eq(2)
    end
  end

  describe 'GET show' do
    let(:session) { create(:session) }

    before do |example|
      next if example.metadata[:skip_before]
      authenticate_request(session)
    end

    it 'returns correct data' do
      technology = create(:technology)

      get :show, params: { id: technology.id }

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_body).not_to be_empty
    end
  end
end
