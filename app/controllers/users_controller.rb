class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def index
        @users = User.all.order('created_at DESC')
        
        render json: @users
    end

    def create
        command = CreateUser.call(params[:name], params[:email], params[:password], params[:password_confirmation] )
        if command.success?
            render json: command.result 
        else
            render json: command.errors
        end
    end

    def show
        @user = User.find(params[:id])
        user = @user.attributes
        
        if params[:friends] == '1'
            user['active_friends'] = @user.active_friends
        end

        render json: user
            
    end

    def me
        user = @current_user.attributes
        if params[:friends] == '1'
            user['active_friends'] = @current_user.active_friends
            user['sent_friends'] = @current_user.sent_friends
            user['pending_friends'] = @current_user.received_friendships

        end

        render json: user
    end

    def update
        if @current_user.id == params[:id].to_i or @current_user.is_admin?
            @user = User.find(params[:id])
            if !@user.update(user_params)
                render json: @user.errors, status: :unprocessable_entity
            end
        else
            render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end

    def destroy
        if @current_user.id == params[:id].to_i or @current_user.is_admin?
            @user = User.find(params[:id])
            @user.destroy
        else
            render json: { error: "Unauthorized" }, status: :unauthorized
        end     
    end

    private

    # Only allow a trusted parameter "white list" through.
    def user_params
        params.required(:user).permit(:name, :email)
    end
end
