class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :get_credentials
  protect_from_forgery

  @@isAdmin = false

  def get_credentials
    current_user = User.find(session[:user_id])
    if current_user.role == "admin"
      @@isAdmin = true
    else
      @@isAdmin = false
    end
  end

  # GET /users
  # GET /users.json

  def index
    if !@@isAdmin
      redirect_to root_url
    else
      @users = User.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.find(params[:id])
    end
  end

  # POST /users
  # POST /users.json
  def create
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if !@@isAdmin
      redirect_to root_url
    else
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end
  
  def upload
  end
end
