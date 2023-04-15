require 'rails_helper'
require './spec/support/shared_examples/models/invalid_codes_validation'

RSpec.describe Translation do
  context 'with valid parameters' do
    let(:translation) { build(:translation) }

    it 'is valid' do
      expect(translation).to be_valid
    end
  end

  context 'with empty parameters' do
    let(:translation) { build(:translation, source_language_code: '', target_language_code: '') }

    it 'is not valid without a name' do
      expect { translation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it_behaves_like 'a invalid codes validation' do
    let(:record) { build(:glossary, source_code: 'xxx', target_code: 'yyy') }
  end

  context 'with source_text too long' do
    let(:translation) { build(:translation, source_text: Faker::String.random(length: 5001)) }

    it 'is not valid' do
      expect { translation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
