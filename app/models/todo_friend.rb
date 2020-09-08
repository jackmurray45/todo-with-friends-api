class TodoFriend < ApplicationRecord
  belongs_to :todo
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:todo_id]
  validate :user_must_be_friends
  validate :user_cannot_be_self

  private
  def user_must_be_friends
      errors.add(:friend, "can't be the same as the user") if !self.todo.user.friends.exists?(self.user_id) && !self.todo.user.received_friends.exists?(self.user_id)
  end

  def user_cannot_be_self
    errors.add(:friend, "can't be the same as the user") if self.todo.user_id == self.user_id
  end


end
