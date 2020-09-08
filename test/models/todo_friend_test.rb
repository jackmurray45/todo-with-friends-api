require 'test_helper'
require 'faker'

class TodoFriendTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")

    @todo = @user.todos.create(title: Faker::Lorem.word)

  end

  test "can only add friends to todo" do

    #create new user and make them friends with first user
    new_user =  User.create(name: Faker::Name.name, email: Faker::Internet.email,
      password: "foobar", password_confirmation: "foobar")

    @user.friendships.create(friend_id: new_user.id)
    new_user.friendships.create(friend_id: @user.id)

    todo_friend = @todo.todo_friends.new(user_id: new_user.id)

    assert todo_friend.valid?

    #create second user that is not friends and try to add them to the Todo
    second_new_user = User.create(name: Faker::Name.name, email: Faker::Internet.email,
      password: "foobar", password_confirmation: "foobar")

    todo_friend_fail = @todo.todo_friends.new(user_id: second_new_user)
    assert_not todo_friend_fail.valid?

    
  end

  test "cannot add user twice" do
    #create new user and make them friends with first user
    new_user =  User.create(name: Faker::Name.name, email: Faker::Internet.email,
      password: "foobar", password_confirmation: "foobar")

    @user.friendships.create(friend_id: new_user.id)
    new_user.friendships.create(friend_id: @user.id)

    @todo.todo_friends.create(user_id: new_user.id)

    todo_friend_fail = @todo.todo_friends.new(user_id: new_user.id)

    assert_not todo_friend_fail.valid?
  end

  test "todo owner cannot be todo friend" do

    todo_friend_fail = @todo.todo_friends.create(user_id: @user.id)

    assert_not todo_friend_fail.valid?
  end

end
