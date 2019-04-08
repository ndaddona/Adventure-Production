class Meeting < ApplicationRecord

    belongs_to :campaign
    validates :title, :start_time, presence: true

    scope :upcoming, -> { where('start_time >= ?', Time.now).order(:start_time) }

end
