require 'rails_helper'

RSpec.describe Api::Translations::Show do
  describe '.call' do
    subject { described_class.new(translation).call }

    context 'when params are valid' do
      context 'with terms' do
        let!(:translation) { create(:translation, source_text: 'This is test text', glossary_id: glossary.id) }
        let!(:glossary) { create(:glossary) }
        let!(:term) { create(:term, glossary_id: glossary.id, source_term: 'test') }

        it 'return highlighted_text and occurrences' do
          expect(subject).to eq(['This is <HIGHLIGHT> test </HIGHLIGHT> text', ['test']])
        end
      end

      context 'without terms' do
        let!(:translation) { create(:translation) }

        it 'return nils' do
          expect(subject).to eq([nil, nil])
        end
      end

      context 'without occurrences' do
        let!(:translation) { create(:translation, source_text: 'This is test text', glossary_id: glossary.id) }
        let!(:glossary) { create(:glossary) }
        let!(:term) { create(:term, glossary_id: glossary.id, source_term: '123') }

        it 'return source text' do
          expect(subject).to eq([translation.source_text, []])
        end
      end

      context 'without translation' do
        let(:translation) { nil }

        it 'raise error' do
          expect(subject).to eq([nil, nil])
        end
      end
    end
  end
end
