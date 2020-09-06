require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = User.create({name: "Test User", email: "test@email.com", 
            password: "TestPassword",password_confirmation: "TestPassword" })

        @other_user = User.create({name: "New User", email: "new@email.com", 
            password: "TestPassword",password_confirmation: "TestPassword" })

    end

    test "can not send friend request twice" do

        other_user_token = JsonWebToken.encode(user_id: @other_user.id)

        post '/friendships/'+@user.id.to_s+"/create_friend_request",
        headers: {
            "Authorization": other_user_token
        }
        assert_equal(1, Friendship.count)
        
        post '/friendships/'+@user.id.to_s+"/create_friend_request",
        headers: {
            "Authorization": other_user_token
        }
        assert_equal(1, Friendship.count)
    end


    test "can not delete friend request that does not exists" do
        other_user_token = JsonWebToken.encode(user_id: @other_user.id)

        delete '/friendships/'+@user.id.to_s+"/delete_friend_request",
        headers: {
            "Authorization": other_user_token
        }

        assert_response :unprocessable_entity
    end

    test "can not send friend request when pending request from same user" do

        other_user_token = JsonWebToken.encode(user_id: @other_user.id)
        post '/friendships/'+@user.id.to_s+"/create_friend_request",
        headers: {
            "Authorization": other_user_token
        }
        assert_response :no_content
        assert_equal(1, Friendship.count)
        

        user_token = JsonWebToken.encode(user_id: @user.id)
        post '/friendships/'+@other_user.id.to_s+"/create_friend_request",
        headers: {
            "Authorization": user_token
        }
        assert_response :unprocessable_entity
        assert_equal(1, Friendship.count)
    end

    test "can not delete friendship that does not exists" do

        other_user_token = JsonWebToken.encode(user_id: @other_user.id)
        delete '/friendships/'+@user.id.to_s+"/delete_friend",
        headers: {
            "Authorization": other_user_token
        }
        
        assert_response :unprocessable_entity
    end

    test "can not delete friendship when only sent friend request" do

        other_user_token = JsonWebToken.encode(user_id: @other_user.id)
        post '/friendships/'+@user.id.to_s+"/create_friend_request",
        headers: {
            "Authorization": other_user_token
        }
        assert_response :no_content

        delete '/friendships/'+@user.id.to_s+"/delete_friend",
        headers: {
            "Authorization": other_user_token
        }
        assert_response :unprocessable_entity

        assert_equal(1, Friendship.count)

    end

end
