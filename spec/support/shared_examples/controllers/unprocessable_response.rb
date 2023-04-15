RSpec.shared_examples 'a unprocessable response', :doc, type: :request do |response_code = 422|
  response(response_code, 'Unprocessable entity response') do
    it 'return error' do
      subject
      expect(response.code).to eq('422')
      expect(json).to eq('error' => [error_message]) if defined?(error_message)
      expect(json).to eq('error' => error_messages) if defined?(error_messages)
    end
  end
end
