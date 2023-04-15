RSpec.shared_examples 'a bad request response', :doc, type: :request do |response_code = 400|
  response(response_code, 'Bad request response') do
    it 'return error' do
      subject
      expect(response).to have_http_status(:bad_request)
      expect(json).to eq('error' => error_message)
    end
  end
end
