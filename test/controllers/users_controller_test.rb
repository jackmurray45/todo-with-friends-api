require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = User.create({name: "Test User", email: "test@email.com", 
            password: "TestPassword",password_confirmation: "TestPassword" })

        @other_user = User.create({name: "New User", email: "new@email.com", 
            password: "TestPassword",password_confirmation: "TestPassword" })
    end

    test "should redirect when token not provided" do
        get users_path

        assert_response :unauthorized
    end

    test "can edit self" do

        other_user_id = @other_user.id
        other_user_token = JsonWebToken.encode(user_id: other_user_id)

        put '/users/'+other_user_id.to_s, 
        params: {
            user: {
                email: "pass@email.com",
                name: "Pass Name"
            }
        },    
        headers: {
            "Authorization": other_user_token
        }

        assert_response :no_content

        assert_equal(1, User.where(name: "Pass Name", email: "pass@email.com").count)
    end

    test "can not edit others" do

        other_user_id = @other_user.id
        other_user_token = JsonWebToken.encode(user_id: other_user_id)

        put '/users/'+@user.id.to_s, 
        params: {
            user: {
                email: "fail@email.com",
                name: "Fail Name"
            }
        },    
        headers: {
            "Authorization": other_user_token
        }

        assert_response :unauthorized
    end
    
end