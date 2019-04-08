class Game < ApplicationRecord
  belongs_to :campaign

  validates :title, :description, presence: true

  scope :search, -> (search) {where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")}

end
