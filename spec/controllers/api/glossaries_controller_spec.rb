require 'rails_helper'
require './spec/support/shared_examples/controllers/successful_response'
require './spec/support/shared_examples/controllers/bad_request_response'
require './spec/support/shared_examples/controllers/not_found_response'
require './spec/support/shared_examples/controllers/unprocessable_response'

RSpec.describe Api::GlossariesController, :doc, type: :request do
  let(:json) { response.parsed_body }

  path '/api/glossaries' do
    get('List glossaries') do
      tags 'Glossaries'
      description 'List glossaries'
      consumes 'application/json'

      subject { get '/api/glossaries', as: :json }

      let!(:glossary_list) { create_list(:glossary, 3) }

      it_behaves_like 'a successful response'
    end

    post('Create glossary') do
      tags 'Glossaries'
      consumes 'application/json'
      description 'Create new glossary'

      parameter name: :glossary, in: :body, schema: { '$ref' => '#/components/schemas/glossary' }

      subject { post '/api/glossaries', params:, as: :json }

      let(:params) { attributes_for(:glossary) }

      response(200, 'Successful response', document: false) do
        it 'creates a new Glossary' do
          expect { subject }.to change(Glossary, :count).by(+1)
        end
      end

      it_behaves_like 'a successful response'

      # renders error when param is missing
      it_behaves_like 'a bad request response', '400 (1)' do
        let(:params) { {} }
        let(:error_message) { 'param is missing or the value is empty: glossary' }
      end

      it_behaves_like 'a bad request response', '400 (2)' do
        let!(:glossary) { create(:glossary, source_code: 'pl', target_code: 'de') }
        let(:params) { { source_code: 'pl', target_code: 'de' } }
        let(:error_message) { I18n.t('glossary.validation_messages.codes') }
      end

      # renders error when codes are missing
      it_behaves_like 'a unprocessable response' do
        let(:params) { { source_code: '', target_code: '' } }
        let(:error_messages) { ["Source code can't be blank", "Target code can't be blank"] }
      end
    end
  end

  path '/api/glossaries/{glossary_id}/terms' do
    post('Creates a term') do
      tags 'Glossaries'
      description 'Creates a term in the given glossary'
      consumes 'application/json'

      parameter name: :glossary_id, in: :path, type: :string, format: :uuid

      parameter name: :term, in: :body, schema: { '$ref' => '#/components/schemas/term' }

      subject { post "/api/glossaries/#{glossary.id}/terms", params: { term: params }, as: :json }

      let!(:glossary) { create(:glossary) }
      let(:params) { attributes_for(:term) }

      it_behaves_like 'a successful response'

      response(200, 'Successful response', document: false) do
        it 'creates term' do
          expect { subject }.to change(Term, :count).by(+1)
        end

        it 'connect term with glossary' do
          subject
          expect(Term.last.glossary).to eq(glossary)
        end
      end

      # renders error when param is missing
      it_behaves_like 'a bad request response' do
        let(:params) { {} }
        let(:error_message) { 'param is missing or the value is empty: term' }
      end

      # renders error when glossary is missing
      it_behaves_like 'a unprocessable response', '422 (1)' do
        subject { post '/api/glossaries/8e0e7929-6a01-4cd1-ba9d-e384484f15b3/terms', params: { term: params }, as: :json }

        let(:error_message) { 'Glossary must exist' }
      end

      # renders error when terms are missing
      it_behaves_like 'a unprocessable response', '422 (2)' do
        let(:params) { { source_term: '', target_term: '' } }
        let(:error_messages) { ["Source term can't be blank", "Target term can't be blank"] }
      end
    end
  end

  path '/api/glossaries/{id}' do
    get('Get glossary') do
      tags 'Glossaries'
      description 'Retrieve information about specific glossary'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, format: :uuid

      subject { get "/api/glossaries/#{glossary.id}", as: :json }

      let!(:glossary) { create(:glossary) }

      it_behaves_like 'a successful response'

      it_behaves_like 'a not found response', 'Glossary' do
        subject { get '/api/glossaries/8e0e7929-6a01-4cd1-ba9d-e384484f15b3', as: :json }
      end
    end
  end
end
