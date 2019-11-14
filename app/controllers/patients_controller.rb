class PatientsController < ApplicationController

  # POST: /patients
  get "/patients" do
    if !logged_in?
      redirect to "/"
    end
    erb :"/patients/index.html"
  end

  # GET: /doctors/signup
  get "/patients/signup" do
    if logged_in? && Patient.find_by(username: session[:username])
      redirect to "/patients"
    end
    @doctors = Doctor.all
    erb :"/patients/signup.html"
  end

  # POST: /doctors/signup
  post "/patients/signup" do
    if logged_in?
      redirect to "/patients"
    end

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/patients/signup"
    else
      patient = Patient.create(first_name: params[:first_name], last_name: params[:last_name],:username => params[:username], :password => params[:password], :email => params[:email], doctor_id: params[:doctor_id])
      session[:user_id] = patient.id
      session[:username] = patient.username
      @name = params[:username]
      session[:message] = "Successfully signed up and logged in as #{@name}!"
          binding.pry
      redirect to "/patients/index"
    end
    redirect "patients/login.html"
  end

  get "/patients/index" do
    @message = session.delete(:message)
    @meds = Med.all
    @patient = current_user_patient
    @doctor = @patient.doctor
    erb :"/patients/index.html"
  end

  # GET: /doctors/login
  get "/patients/login" do
    @message = session.delete(:message)
    erb :"/patients/login.html"
  end

  # POST: /doctors/signup
  post "/patients/signup" do
    redirect "/patients/index.html"
  end

  # GET: /patients
  get "/patients" do
    erb :"/patients/index.html"
  end

  # GET: /patients/new
  get "/patients/new" do
    erb :"/patients/new.html"
  end

  # GET: /patients/username/5
  get "/patients/:slug/:id" do
    erb :"/patients/show.html"
  end

  # GET: /patients/username/5/edit
  get "/patients/:slug/:id/edit" do
    erb :"/patients/edit.html"
  end

  # PATCH: /patients/username/5
  patch "/patients/:slug/:id" do
    redirect "/patients/:id"
  end

  # DELETE: /patients/5/delete
  delete "/patients/:slug/:id/delete" do
    redirect "/patients"
  end


end
