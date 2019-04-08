class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
