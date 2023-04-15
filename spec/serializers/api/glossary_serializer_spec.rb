require 'rails_helper'

RSpec.describe Api::GlossarySerializer do
  context 'when data is valid' do
    let!(:glossary) { create(:glossary) }

    let(:serialized_data) { described_class.new(glossary).serializable_hash }

    it 'returns proper structure of data' do
      expect(serialized_data.keys).to match(%i[id source_code target_code terms])
    end
  end
end
