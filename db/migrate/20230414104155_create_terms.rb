class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :source_term, null: false
      t.string :target_term, null: false

      t.references :glossary, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
