require 'test_helper'
require 'faker'

class FriendshipTest < ActiveSupport::TestCase
  test "no duplicate friendship" do
    User.create(name: Faker::Name.name, email: Faker::Internet.email,
      password: "foobar", password_confirmation: "foobar")
    User.create(name: Faker::Name.name, email: Faker::Internet.email,
      password: "foobar", password_confirmation: "foobar")

    Friendship.create(user_id: 1, friend_id: 2)
    friendship = Friendship.new(user_id: 1, friend_id: 2)

    assert_not friendship.valid?
  end
end
