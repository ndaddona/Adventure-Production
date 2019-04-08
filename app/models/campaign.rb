class Campaign < ApplicationRecord

    belongs_to :user
    has_many :games, dependent: :destroy
    has_many :meetings, dependent: :destroy
    has_many :signups, dependent: :destroy
    has_many :joined, through: :signups, source: :user
    validates :name, :description, :category, presence: true

    scope :search, -> (search) {where("name LIKE ? OR description LIKE ? OR category LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") }
end
