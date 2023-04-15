require 'faker'

FactoryBot.define do
  factory :translation do
    transient do
      csv_file { CSV.parse(Rails.root.join('lib/language-codes.csv').read, headers: true) }
    end

    source_text { Faker::Quote.famous_last_words }
    source_language_code { csv_file.by_col['code'].sample }
    target_language_code { csv_file.by_col['code'].sample }

    trait :with_glossary do
      glossary_id { create(:glossary).id }
    end
  end
end
