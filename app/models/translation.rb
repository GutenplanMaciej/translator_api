class Translation < ApplicationRecord
  belongs_to :glossary, optional: true
  has_many :terms, through: :glossary

  validates :source_language_code, presence: true
  validates :target_language_code, presence: true
  validates :source_text, presence: true, length: { maximum: 5000 }

  validate :codes_validation

  def codes_validation
    super(source_language_code, target_language_code)
  end
end
