class Event < ApplicationRecord

    has_many :attendees_table, class_name: "AttendEvent",
                              foreign_key: "event_id",
                                dependent: :destroy 

    has_one  :creator_table,   class_name: "CreateEvent",
                              foreign_key: "event_id",
                                dependent: :destroy
                                
    has_many :attendees, through: :attendees_table, source: :user

    has_one  :creator, through: :creator_table, source: :user

    validate  :date_check

    validates :name, presence: true, uniqueness: { case_sensitive: false },
                                         length: { maximum: 100 }

    validates :description, presence: true, length: { minimum: 10, 
                                                            maximum: 500 }

    validates :event_type, presence: true, length: { maximum: 20 }

    validates :event_start_at, presence: true
    
    validates :event_end_at  , presence: true

    def date_check
        if event_end_at < Time.new
            errors.add(:event, "Event ended.")
        elsif event_start_at >= event_end_at
            errors.add(:event, "Invalid end date.")
        end
    end
    
end
