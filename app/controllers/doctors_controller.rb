class DoctorsController < ApplicationController

  # GET: /doctors
  get "/doctors" do
    if !logged_in?
      redirect to "/"
    end
    @doctor = Doctor.find_by(username: session[:username])
    erb :"/doctors/index.html"
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
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:last_name] == "" || params[:first_name] == ""
      flash[:message] = "**All fields must be filled in!**"
      redirect to "/doctors/signup"
    else
      @doctor = Doctor.create(first_name: params[:first_name], last_name: params[:last_name],:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @doctor.id
      session[:username] = @doctor.username
      @name = params[:username]
      session[:message] = "Successfully signed up and logged in as #{@name}!"
      redirect to "/doctors/index"
    end
  end

  get "/doctors/index" do
    @doctor = current_user_doctor
    @message = session.delete(:message)
    @patients = Patient.all
    erb :"/doctors/index.html"
  end

  # GET: /doctors/login
  get "/doctors/login" do
    if logged_in?
      redirect to "/doctors"
    end
    erb :"/doctors/login.html"
  end

  post "/doctors/login" do
    @doctor = Doctor.find_by(username: params[:username])
    if @doctor && @doctor.authenticate(params[:password])
      session[:user_id] = @doctor.id
      session[:username] = @doctor.username
      redirect to "/doctors"
    else
      flash[:message] = "**We can't find that username and password!**"
      redirect to "/doctors/login"
    end
  end

  # GET: /doctors/new
  get "/doctors/new" do
    if !logged_in?
      redirect to "/"
    end
    erb :"/doctors/new.html"
  end

  post "/doctors/new" do
  @doctor = current_user_doctor
    if params[:email] == "" || params[:last_name] == "" || params[:first_name] == ""
      flash[:message] = "**All fields must be filled in!**"
      redirect to "/doctors/new"
    else
      @patient = Patient.create(first_name: params[:first_name], last_name: params[:last_name], :email => params[:email], username: "#{params[:last_name]}#{params[:first_name]}", password: "password", doctor_id: @doctor.id)
      flash[:notice] = "Successfully added patient #{@patient.last_name}, #{@patient.first_name}!"
      redirect to "/doctors/index"
    end
  end

  get "/doctors/:slug/:id" do
    @doctor = current_user_doctor
    @patient = Patient.find(params[:id])
    @meds = Med.all
    erb :"/doctors/show.html"
  end

  # GET: /doctors/username/edit
  get "/doctors/:slug/:id/edit" do
    @doctor = current_user_doctor
    @patient = Patient.find(params[:id])
    @meds = Med.all
    erb :"/doctors/edit.html"
  end

  # PATCH: /doctors/username
  patch "/doctors/:slug/:id" do
    @patient = Patient.find(params[:id])
    @patient_med = PatientMed.all
    if params[:first_name] == ""
      params[:first_name] = @patient.first_name
    end

    if params[:last_name] == ""
      params[:last_name] = @patient.last_name
    end

    if params[:email] == ""
      params[:email] = @patient.email
    end

    @patient.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    @patient.patient_meds.find_or_create_by(med: Med.find(params[:med]))
    @patient.save
    flash[:update] = "**You've successfully updated your account information!**"
    redirect to "/doctors"
  end

  # DELETE: /doctors/username/delete
  delete "/doctors/:slug/:id/delete" do
    redirect "/logout"
  end


end
