RSpec.shared_examples 'a successful response', :dpc, type: :request do
  response(200, 'Successful response') do
    it 'successful response' do
      subject
      expect(response).to be_successful
    end
  end
end
