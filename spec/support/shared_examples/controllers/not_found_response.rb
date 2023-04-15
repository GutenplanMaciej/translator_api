RSpec.shared_examples 'a not found response', :doc, type: :request do |record_name|
  response(404, 'Not found response') do
    it do
      subject
      expect(response).to have_http_status(:not_found)
      expect(json).to eq('error' => "Couldn't find #{record_name} with 'id'=8e0e7929-6a01-4cd1-ba9d-e384484f15b3")
    end
  end
end
