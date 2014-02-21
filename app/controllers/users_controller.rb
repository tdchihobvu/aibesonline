class UsersController < ApplicationController
  filter_access_to :all
#  def new
#    @user = User.new
#    @num1 = @user.generate_first_number
#    @num2 = @user.generate_second_number
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @user }
#    end
#  end
#
#  def create
#    @user = User.new(params[:user])
#    @user.random_pass = User.generate_activation_code
#    @num1 = @user.generate_first_number
#    @num2 = @user.generate_second_number
#    result = (params[:user][:number1]).to_i + (params[:user][:number2]).to_i
#    puts("result for #{params[:user][:number1]} and #{params[:user][:number2]} is #{result}")
#    given_answer = params[:user][:answer]
#    puts("the result given is #{given_answer}")
#
#    respond_to do |format|
#      if @user.save
#        user = @user.id
#        UserEmail.user_email(user).deliver
#        redirect_to_index('An access token and activation link has been sent to your email. Activate your account before you login.')
#        format.json { render json: @user, status: :created, location: @user }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#    rescue SocketError
#      logger.error("Email Failure: Error occured whilst trying to send an email for access code #{@user.name}.")
#      redirect_to_index('Error in connection. An error occured whilst trying to send you an email. ')
#
#  end
#
#  private
#
#  def redirect_to_index(msg = nil)
#    flash[:notice] = msg if msg
#    redirect_to :controller => 'store', :action => 'index'
#  end
  # GET /users
  # GET /users.json
#  def index
#    @users = User.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @users }
#    end
#  end

  # GET /users/1
  # GET /users/1.json
#  def show
#    @user = User.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @user }
#    end
#  end

  # GET /users/new
  # GET /users/new.json
  

  # GET /users/1/edit
#  def edit
#    @user = User.find(params[:id])
#  end

  # POST /users
  # POST /users.json
  

  # PUT /users/1
  # PUT /users/1.json
#  def update
#    @user = User.find(params[:id])
#
#    respond_to do |format|
#      if @user.update_attributes(params[:user])
#        format.html { redirect_to @user, notice: 'User was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /users/1
  # DELETE /users/1.json
#  def destroy
#    @user = User.find(params[:id])
#    @user.destroy
#
#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :no_content }
#    end
#  end

  
end
