class UsersController < ApplicationController
  def index
    @users = User.all

    render json: { user: @users.as_json(only: [:id, :email, :access_token,
                                              :full_name,
                                              :username, :admin]) },
      status: :created
  end

  def register
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.new(email: params[:email],
                     password: passhash,
                     full_name: params[:full_name],
                     username: params[:username])
    if @user.save
      render json: { user: @user.as_json(only: [:id, :email, :access_token,
                                                :full_name,
                                                :username]) },
        status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def login
    passhash = Digest::SHA1.hexdigest(params[:password])
    @user = User.find_by(password: passhash,
                     username: params[:username])
    if @user

      render json: { user: @user.as_json(only: [:id, :email, :access_token,
                                                :full_name, :admin
                                                :username]) },
        status: :ok
    else
      render json: { message: "Invalid Login" },
        status: :unauthenticated
    end
  end
end
