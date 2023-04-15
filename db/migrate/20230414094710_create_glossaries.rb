class CreateGlossaries < ActiveRecord::Migration[7.0]
  def change
    create_table :glossaries, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :source_code, null: false
      t.string :target_code, null: false

      t.index %i[source_code target_code], unique: true

      t.timestamps
    end
  end
end
