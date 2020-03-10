class User < ApplicationRecord

    attr_accessor :remember_token

    before_create { email.downcase! }
    has_secure_password

    has_many :attended_events_table, class_name: "AttendEvent",
                                    foreign_key: "user_id"
                                                            


    has_many :created_events_table,  class_name: "CreateEvent",
                                    foreign_key: "user_id",
                                      dependent: :destroy

    has_many :attended_events, through: :attended_events_table, source: :event 

    has_many :created_events,  through: :created_events_table, source: :event

    has_many :sended_invitations,   class_name: "Invitation",
                                   foreign_key: "inviter_id",
                                     dependent: :destroy

    has_many :received_invitations, class_name: "Invitation",
                                   foreign_key: "invited_id",
                                     dependent: :destroy

    has_many :invitings, through: :sended_invitations, source: :invited

    has_many :inviters,  through: :received_invitations

    

    validates :name, presence: true, uniqueness: { case_sensitive: true }, 
                                                  length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                        length: { maximum: 75 }, format: { with: VALID_EMAIL_REGEX }

    validates :password, presence: true, length: { minimum:6, maximum:150 } 
    
    class << self

        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? 
                        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost                                                          
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end

    def remember
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(@remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
end
