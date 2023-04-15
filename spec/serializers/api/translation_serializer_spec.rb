require 'rails_helper'

RSpec.describe Api::TranslationSerializer do
  context 'when data is valid' do
    let!(:translation) { create(:translation) }

    let(:serialized_data) { described_class.new(translation).serializable_hash }

    it 'returns proper structure of data' do
      expect(serialized_data.keys).to match(%i[id source_language_code target_language_code source_text glossary highlighted_text occurrences])
    end
  end
end
