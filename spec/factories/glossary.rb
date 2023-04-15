require 'faker'

FactoryBot.define do
  factory :glossary do
    transient do
      csv_file { CSV.parse(Rails.root.join('lib/language-codes.csv').read, headers: true) }
    end

    source_code { csv_file.by_col['code'].sample }
    target_code { csv_file.by_col['code'].sample }

    after(:create) do |glossary|
      create_list(:term, 2, glossary_id: glossary.id)
    end
  end
end
