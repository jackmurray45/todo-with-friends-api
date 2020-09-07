class Todo < ApplicationRecord
    has_many :users
    belongs_to :user

    validates :title, presence: true, allow_blank: false


end
