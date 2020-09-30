require 'test_helper'

class TodoItemTest < ActiveSupport::TestCase

  def setup
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")

    @todo = @user.todos.create(title: Faker::Lorem.word)
  end

  test "can create item" do
    todo_item = @todo.todo_items.create(content: Faker::Lorem.word)
    
    assert todo_item.valid?
    assert_equal 1, TodoItem.count
  end

  test "todo_item set status to true" do
    todo_item = @todo.todo_items.create(content: Faker::Lorem.word)

    #default status is false
    assert_not todo_item.status

    #set status to true
    todo_item.update(status: true)
    assert todo_item.valid?
    #check that status has changed to tru
    assert todo_item.status
  end

  test "is_due returns true when due_date has passed" do
    todo_item = @todo.todo_items.create(content: Faker::Lorem.word, due_by: Date.today-1)

    assert todo_item.valid?
    #check that status has changed to tru
    assert todo_item.is_due?
  end

  test "is_due returns false when due_date has not passed" do
    todo_item = @todo.todo_items.create(content: Faker::Lorem.word, due_by: Date.today+1)

    assert todo_item.valid?
    #check that status has changed to tru
    assert_not todo_item.is_due?
  end

end
