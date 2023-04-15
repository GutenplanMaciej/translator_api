require 'rails_helper'

RSpec.describe Term do
  context 'with valid parameters' do
    let(:term) { build(:term) }

    it 'is valid' do
      expect(term).to be_valid
    end
  end

  context 'with empty parameters' do
    let(:term) { build(:term, source_term: '', target_term: '') }

    it 'is not valid' do
      expect { term.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
