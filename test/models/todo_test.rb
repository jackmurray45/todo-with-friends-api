require 'test_helper'
require 'faker'

class TodoTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")
  end

  test "create todo through user" do
    todo = @user.todos.new(title: Faker::Lorem.word)

    assert todo.valid?
  end

  test "title cannot be empty" do
    todo = Todo.new(title: '', user_id: @user.id)
    assert_not todo.valid?
  end

  test "get user from todo" do
    todo = Todo.new(title: '', user_id: @user.id)
    assert_equal @user.id, todo.user.id
  end

end
