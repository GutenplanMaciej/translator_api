class Glossary < ApplicationRecord
  has_many :terms, dependent: :destroy
  has_many :translations

  validates :source_code, presence: true
  validates :target_code, presence: true
  validate :codes_validation

  def codes_validation
    super(source_code, target_code)
  end
end
