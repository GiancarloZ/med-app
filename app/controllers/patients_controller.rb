class PatientsController < ApplicationController
  # POST: /patients
  get "/patients" do
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      @patient = Patient.find_by(username: session[:username])
      redirect to :"/patients/index"
    else
      redirect to "/"
    end
  end

  # GET: /doctors/signup
  get "/patients/signup" do
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      redirect to "/patients"
    end
    @doctors = Doctor.all
    erb :"/patients/signup.html"
  end

  # POST: /doctors/signup
  post "/patients/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:last_name] == "" || params[:first_name] == "" || params[:doctor_id] == nil
      flash[:message] = "**All fields must be filled in!**"
      redirect to "/patients/signup"
    else
      patient = Patient.create(first_name: params[:first_name], last_name: params[:last_name],:username => params[:username], :password => params[:password], :email => params[:email], doctor_id: params[:doctor_id])
      session[:user_id] = patient.id
      session[:username] = patient.username
      @name = params[:username]
      session[:message] = "Successfully signed up and logged in as #{@name}!"
      redirect to "/patients/index"
    end
  end

  get "/patients/index" do
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      @message = session.delete(:message)
      @meds = Med.all
      @patient = current_user_patient
      @doctor = @patient.doctor
      erb :"/patients/index.html"
    else
      redirect to "/"
    end
  end

  # GET: /doctors/login
  get "/patients/login" do
    @message = session.delete(:message)
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      redirect to "/patients"
    end

    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      redirect to "/doctors"
    end
    erb :"/patients/login.html"
  end

  post "/patients/login" do
    @patient = Patient.find_by(id: session[:user_id], username: params[:username])
    if @patient && @patient.authenticate(params[:password])
      session[:user_id] = @patient.id
      session[:username] = @patient.username
      redirect to "/patients"
    else
      flash[:message] = "**We can't find that username and password!**"
      redirect to "/patients/login"
    end
  end

  # GET: /patients/username/5/edit
  get "/patients/:id/edit" do
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      @patient = current_user_patient
      erb :"/patients/edit.html"
    else
      redirect to "/"
    end
  end

  # PATCH: /patients/username/5, editing patient user account
  patch "/patients/:id" do
    @patient = current_user_patient
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
    flash[:update] = "**You've successfully updated your account information!**"
    redirect "/patients/#{@patient.id}/edit"
  end

  # DELETE: /patients/5/delete
  delete "/patients/:id/delete" do
    @patient = Patient.find(params[:id])
    @patient.delete
    redirect "/logout"
  end


end
