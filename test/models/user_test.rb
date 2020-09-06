require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: Faker::Name.name, email: Faker::Internet.email,
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should valid user" do
    assert @user.valid?
  end

  test "no duplicate emails" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password must be confirmed" do
    @user.password_confirmation = 'fail'
    @user.save
    assert_not @user.valid?
  end

end
