class CoursesController < ApplicationController
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

  # GET /courses
  # GET /courses.json
  def index
    if @@isAdmin
      @courses = Course.all
    else
      user = User.find(session[:user_id]) if session[:user_id]
      @courses = user.courses
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    if @@isAdmin
      @course = Course.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @course }
      end
    else
      redirect_to courses_url
    end
  end

  # GET /courses/1/edit
  def edit
    if @@isAdmin
      @course = Course.find(params[:id])
    else
      redirect_to courses_url
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    if @@isAdmin
      @course = Course.new(params[:course])

      respond_to do |format|
        if @course.save
          format.html { redirect_to @course, notice: 'Course was successfully created.' }
          format.json { render json: @course, status: :created, location: @course }
        else
          format.html { render action: "new" }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to courses_url
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    if @@isAdmin
      @course = Course.find(params[:id])

      respond_to do |format|
        if @course.update_attributes(params[:course])
          format.html { redirect_to @course, notice: 'Course was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to courses_url
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    if @@isAdmin
      @course = Course.find(params[:id])
      @course.destroy

      respond_to do |format|
        format.html { redirect_to courses_url }
        format.json { head :no_content }
      end
    else
      redirect_to courses_url
    end
  end

  def add_announcement
    if @@isAdmin == false
      redirect_to courses_url
    end
    @course = Course.find(params[:id])
    @course.Announcement = params[:announcement]
    if(params[:announcement])
      if(@course.save)
        redirect_to @course, notice: 'Announcement was successfully added to course'
      end
    end
  end

  def add_student
    if @@isAdmin == false
      redirect_to courses_url
    end
    @course = Course.find(params[:id])
    user_to_add = User.find_by(email: params[:email])
    if(user_to_add)
      @course.users << user_to_add
      @course.save
      user_to_add << course
      user_to_add.save
      redirect_to @course, notice: 'Student was successfully added to course'
    else
      @valid_input = false
    end
    if !params[:email] and !user_to_add 
      @valid_input = true
    end
  end
end