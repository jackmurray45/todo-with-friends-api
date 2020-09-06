class FriendshipsController < ApplicationController
  def create_friend_request
    #If we already do not have a friend request and are not already friends...
    if @current_user.friends.exists?(params[:id]) | @current_user.received_friends.exists?(params[:id])
      render json: { error: "Already friends or already sent friend request." }, status: :unprocessable_entity
    else
      @current_user.friendships.create(friend_id: params[:id]) 
      render json: nil, status: :no_content  
    end

  end

  def delete_friend_request
    #If don't have a friend request and the users aren't already friends
    if !@current_user.friends.exists?(params[:id]) | (@current_user.friends.exists?(params[:id]) & @current_user.received_friendships.exists?(params[:id]))
      render json: { error: "Friend request not found." }, status: :unprocessable_entity
    else
      @current_user.friendships.delete_by(friend_id: params[:id])
      render json: nil, status: :no_content 
    end
  end

  def accept_friend_request
    #If don't have a friend request found
    if !@current_user.received_friends.exists?(params[:id])
      render json: { error: "Friend request not found." }, status: :unprocessable_entity
    else
      @current_user.friendships.create(friend_id: params[:id])
      render json: nil, status: :no_content
      
    end
  end

  def delete_friend
    #If don't have this friend relationship found
    if !@current_user.friends.exists?(params[:id]) || !@current_user.received_friends.exists?(params[:id])
      render json: { error: "Friend not found." }, status: :unprocessable_entity
    else
      @current_user.friendships.delete_by(friend_id: params[:id])
      @current_user.received_friendships.delete_by(user_id: params[:id])
      render json: nil, status: :no_content 
    end
  end
end
