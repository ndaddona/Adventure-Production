class ChangegameToGame < ActiveRecord::Migration[5.2]
  def change
    rename_table :games, :games
  end
end
