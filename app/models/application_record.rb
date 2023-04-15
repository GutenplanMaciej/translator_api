require 'csv'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def codes_validation(source_code, target_code)
    return if source_code.blank? || target_code.blank?

    csv = CSV.parse(Rails.root.join('lib/language-codes.csv').read, headers: true)

    if csv
      codes = csv.by_col['code']
      errors.add(:source_code, I18n.t('errors.validation.source_code')) unless codes.include?(source_code)
      errors.add(:target_code, I18n.t('errors.validation.target_code')) unless codes.include?(target_code)
    end
  rescue CSV::MalformedCSVError
    errors.add(:source_code, I18n.t('glossary.validation_messages.csv_error'))
  end
end
