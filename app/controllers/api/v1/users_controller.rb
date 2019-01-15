class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  
  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    puts current_user
    render json: @user
  end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render json: { user: UserSerializer.new(@user) }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # def find_current_user 
  #   token = request.headers['Authorization'].split(" ")[1] # -> "Bearer {token}" -> just the token 
  #   decoded_token = JWT.decode(token, ENV[SOME_SUPER_SECRET], true, algorithm: HS526) # -> 
  # end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
