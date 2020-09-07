require 'test_helper'
require 'faker'

class TodoTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")
  end

  test "create todo through user" do
    todo = @user.todos.new(title: Faker::Lorem.word, due_by: Faker::Time)

    assert todo.valid?
  end

  test "title cannot be empty" do
    todo = Todo.new(title: '', due_by: Faker::Time, user_id: @user.id)
    assert_not todo.valid?
  end

  test "due by can be null" do
    todo = Todo.new(title: Faker::Lorem.word, user_id: @user.id)
    assert todo.valid?
  end





end
