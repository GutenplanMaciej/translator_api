class LanguageCodesError < StandardError
  def initialize(msg = I18n.t('errors.language_codes'))
    super
  end
end
