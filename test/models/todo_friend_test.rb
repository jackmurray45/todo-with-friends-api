require 'test_helper'
require 'faker'

class TodoFriendTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")

    todo = @user.todos.new(title: Faker::Lorem.word, due_by: Faker::Time)
  end

  test "can only add friends to todo" do
    assert false
  end

  test "cannot add user twice" do
    assert false
  end

end
