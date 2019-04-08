class AddImageToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :image_file_name, :string
  end
end
