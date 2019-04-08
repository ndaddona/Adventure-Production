class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.text :description
      t.string :image_file_name, default: ""
      t.string :gm
      t.string :players

      t.timestamps
    end
  end
end
