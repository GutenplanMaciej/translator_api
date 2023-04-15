require 'rails_helper'
require './spec/support/shared_examples/models/invalid_codes_validation'

RSpec.describe Glossary do
  context 'with valid parameters' do
    let(:glossary) { build(:glossary) }

    it 'is valid' do
      expect(glossary).to be_valid
    end
  end

  context 'with relation objects' do
    let(:glossary) { create(:glossary) }

    it 'attach to_many relation' do
      expect(glossary.terms).not_to be_empty
    end
  end

  context 'with invalid parameters' do
    it_behaves_like 'a invalid codes validation' do
      let(:record) { build(:glossary, source_code: 'xxx', target_code: 'yyy') }
    end

    context 'when codes are already taken' do
      let!(:glossary_1) { create(:glossary, source_code: 'pl', target_code: 'de') }
      let(:glossary_2) { build(:glossary, source_code: 'pl', target_code: 'de') }

      it 'is not valid without a name' do
        expect { glossary_2.save! }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  context 'with empty parameters' do
    let(:glossary) { build(:glossary, source_code: '', target_code: '') }

    it 'is not valid' do
      expect { glossary.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
