class AddCatToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :category, :string
  end
end
