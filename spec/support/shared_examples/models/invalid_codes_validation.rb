RSpec.shared_examples 'a invalid codes validation' do
  it 'failed validation' do
    expect(record).not_to be_valid
    expect(record.errors.map(&:type)).to include(I18n.t('errors.validation.source_code'), I18n.t('errors.validation.target_code'))
  end
end
