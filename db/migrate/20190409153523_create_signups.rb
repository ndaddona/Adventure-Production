class CreateSignups < ActiveRecord::Migration[5.2]
  def change
    create_table :signups do |t|
      t.references :user, foreign_key: true
      t.references :campaign, foreign_key: true
    end
  end
end
