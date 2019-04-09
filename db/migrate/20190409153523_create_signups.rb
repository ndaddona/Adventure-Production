class CreateSignups < ActiveRecord::Migration[5.2]
  def change
    create_table :signups do |t|
      t.references :users, foreign_key: true
      t.references :campaigns, foreign_key: true
    end
  end
end
