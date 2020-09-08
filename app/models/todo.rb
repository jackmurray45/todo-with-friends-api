class Todo < ApplicationRecord
    has_many :todo_friends, dependent: :destroy
    belongs_to :user

    validates :title, presence: true, allow_blank: false


end
