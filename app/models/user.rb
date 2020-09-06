class User < ApplicationRecord
    has_secure_password

    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
    has_many :received_friends, through: :received_friendships, source: 'user'

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates_confirmation_of :password
    validates :password, length: { minimum: 6 }, on: :create
    validates :name, presence: true, length: { maximum: 50 }

    def active_friends
        friends.select{ |friend| friend.friends.include?(self) }  
    end
    
    def sent_friends
        friends.select{ |friend| !friend.friends.include?(self) }  
    end

    def is_admin?
        self.id == 1
    end
    
end
