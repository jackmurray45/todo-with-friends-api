class TodoItem < ApplicationRecord
  belongs_to :todo

  validates :content, presence: true, allow_blank: false

  def is_due?
    self.due_by <= Time.current
  end
end
