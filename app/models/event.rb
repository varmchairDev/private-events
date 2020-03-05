class Event < ApplicationRecord

    has_many :attendees, through: :attendances, class: "Attendance"
                                          foreign_key: "user_id"
                                               source: :user,
                                            dependent: :destroy 

    belong_to  :creator, through: :attendances, class: "Attendance"
                                          foreign_key: "user_id",
                                               source: :user

    has_many :invitations, dependent: :destroy

    validate  :date_check

    validates :name, presence: true, uniqueness: { case_sensitive: false }
                                         length: { maximum: 100 }

    validates :description, presence: true, length: { minimum: 10, 
                                                            maximum: 500 }

    validates :event_type, presence: true, length: { maximum: 20 }

    validates :event_start_at, presence: true
    
    validates :event_end_at  , presence: true

    def date_check
        if event_start_at < Date.now
            errors.add(:event, "Event ended.")
        elsif event_start_at >= event_end_at
            errors.add(:event, "Invalid end date.")
        end
    end
    
end
