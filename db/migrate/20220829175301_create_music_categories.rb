class CreateMusicCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :music_categories do |t|
      t.references :music, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
