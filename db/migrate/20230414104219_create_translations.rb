class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :source_language_code, null: false
      t.string :target_language_code, null: false
      t.string :source_text, null: false
      t.uuid :glossary_id

      t.timestamps
    end
  end
end
