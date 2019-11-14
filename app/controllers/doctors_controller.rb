class DoctorsController < ApplicationController

  # GET: /doctors
  get "/doctors" do
    erb :"/doctors/index.html"
  end

  # POST: /doctors
  post "/doctors" do
    redirect "/doctors"
  end

  # GET: /doctors/signup
  get "/doctors/signup" do
    if logged_in? && Doctor.find_by(username: session[:username])
      redirect to "/doctors"
    end
    erb :"/doctors/signup.html"
  end

  # POST: /doctors/signup
  post "/doctors/signup" do
    if logged_in?
      redirect to "/doctors"
    end

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/doctors/signup"
    else
      doctor = Doctor.create(first_name: params[:first_name], last_name: params[:last_name],:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = doctor.id
      session[:username] = doctor.username
      @name = params[:username]
      session[:message] = "Successfully created signed up and logged in as #{@name}!"
      redirect to "/doctors/index"
    end
    redirect "/doctors/login.html"
  end

  get "/doctors/index" do
    @message = session.delete(:message)
    @patients = Patient.all
    @doctor = current_user_doctor
    erb :"/doctors/index.html"
  end

  # GET: /doctors/login
  get "/doctors/login" do
    erb :"/doctors/login.html"
  end

  # POST: /doctors/signup
  post "/doctors/signup" do
    redirect "/doctors/index.html"
  end

  # GET: /doctors/new
  get "/doctors/new" do
    erb :"/doctors/new.html"
  end

  # GET: /doctors/5
  get "/doctors/:slug" do
    erb :"/doctors/show.html"
  end

  # GET: /doctors/username/edit
  get "/doctors/:slug/:id/edit" do
    erb :"/doctors/edit.html"
  end

  # PATCH: /doctors/username
  patch "/doctors/:slug/:id" do
    redirect "/doctors/:id"
  end

  # DELETE: /doctors/username/delete
  delete "/doctors/:slug/:id/delete" do
    redirect "/doctors"
  end


end
