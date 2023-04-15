require 'rails_helper'

RSpec.describe Api::Translations::Create do
  describe '.call' do
    subject { described_class.new(params).call }

    context 'when params are valid' do
      context 'with glossary' do
        let(:glossary) { create(:glossary, source_code: 'pl', target_code: 'en') }
        let(:params) { attributes_for(:translation, source_language_code: 'pl', target_language_code: 'en', glossary:) }

        it 'create translation' do
          expect { subject }.to change(Translation, :count).by(+1)
        end
      end

      context 'without glossary' do
        let(:params) { attributes_for(:translation) }

        it 'create translation' do
          expect { subject }.to change(Translation, :count).by(+1)
        end
      end
    end

    context 'when params are invalid' do
      context 'with wrong codes' do
        let(:glossary) { create(:glossary) }
        let(:params) { { source_text: 'test', source_language_code: 'pl', target_language_code: 'en', glossary_id: glossary.id } }

        it 'raise error' do
          expect { subject }.to raise_error(LanguageCodesError)
        end
      end

      context 'with wrong text' do
        let(:params) { attributes_for(:translation, source_text: '') }

        it 'raise error' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
