class Signup < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  scope :playin, ->(user) {where(user_id: user).order(:campaign_id)}
end
