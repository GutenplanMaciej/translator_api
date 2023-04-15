require 'rails_helper'
require './spec/support/shared_examples/controllers/successful_response'
require './spec/support/shared_examples/controllers/bad_request_response'
require './spec/support/shared_examples/controllers/not_found_response'
require './spec/support/shared_examples/controllers/unprocessable_response'

RSpec.describe Api::TranslationsController, :doc, type: :request do
  let(:json) { response.parsed_body }

  path '/api/translations' do
    post('Create translations') do
      tags 'Translations'
      consumes 'application/json'
      description 'Create new translation'

      parameter name: :translation, in: :body, schema: { '$ref' => '#/components/schemas/translation' }

      subject { post '/api/translations', params:, as: :json }

      let(:glossary) { create(:glossary) }
      let(:params) do
        attributes_for(:translation, source_language_code: glossary.source_code, target_language_code: glossary.target_code, glossary_id: glossary.id)
      end

      response(200, 'Successful response', document: false) do
        it 'creates a new translations' do
          expect { subject }.to change(Translation, :count).by(+1)
        end
      end

      it_behaves_like 'a successful response'

      # renders error when param is missing
      it_behaves_like 'a bad request response', '400 (1)' do
        let(:params) { {} }
        let(:error_message) { 'param is missing or the value is empty: translation' }
      end

      # renders error when params are invalid
      it_behaves_like 'a bad request response', '400 (2)' do
        let(:glossary) { create(:glossary, source_code: 'pl', target_code: 'en') }

        let(:params) { attributes_for(:translation, source_language_code: 'de', target_language_code: 'fr').merge(glossary_id: glossary.id) }
        let(:error_message) { I18n.t('errors.language_codes') }
      end

      # renders error when codes are missing
      it_behaves_like 'a unprocessable response', '422 (1)' do
        let(:params) { { source_language_code: '', target_language_code: '', source_text: '' } }
        let(:error_messages) { ["Source language code can't be blank", "Target language code can't be blank", "Source text can't be blank"] }
      end

      # renders error when text is too long
      it_behaves_like 'a unprocessable response', '422 (2)' do
        let(:params) { attributes_for(:translation, source_text: Faker::String.random(length: 5001)) }
        let(:error_message) { 'Source text is too long (maximum is 5000 characters)' }
      end
    end
  end

  path '/api/translations/{id}' do
    get('Get translation') do
      tags 'Translations'
      description 'Retrieve information about specific translation'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, format: :uuid

      subject { get "/api/translations/#{translation.id}", as: :json }

      let!(:translation) { create(:translation, source_text: 'This is test text', glossary_id: glossary.id) }
      let!(:glossary) { create(:glossary) }
      let!(:term) { create(:term, glossary_id: glossary.id, source_term: 'test') }

      it_behaves_like 'a successful response'

      it_behaves_like 'a not found response', 'Translation' do
        subject { get '/api/translations/8e0e7929-6a01-4cd1-ba9d-e384484f15b3', as: :json }
      end

      response(200, 'Successful response', document: false) do
        context 'when translation do not have terms' do
          let!(:translation) { create(:translation) }

          it 'return successful response' do
            subject
            expect(response).to be_successful
          end
        end
      end
    end
  end
end
