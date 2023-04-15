require 'faker'

FactoryBot.define do
  factory :term do
    glossary
    source_term { Faker::Quote.famous_last_words }
    target_term { Faker::Quote.famous_last_words }
  end
end
