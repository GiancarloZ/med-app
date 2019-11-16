class DoctorsController < ApplicationController

  # GET: /doctors
  get "/doctors" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = Doctor.find_by(username: session[:username])
      erb :"/doctors/index.html"
    else
      redirect to "/"
    end
  end

  # GET: /doctors/signup
  get "/doctors/signup" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      erb :"/doctors/signup.html"
    else
      redirect to "/"
    end
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
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      @message = session.delete(:message)
      @patients = Patient.all
      erb :"/doctors/index.html"
    else
      redirect to "/"
    end
  end

  # GET: /doctors/login
  get "/doctors/login" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      redirect to "/doctors"
    elsif logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      redirect to "/"
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
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      @meds = Med.all
      erb :"/doctors/new.html"
    else
      redirect to "/"
    end
  end

  get "/doctors/account" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      erb :"/doctors/account.html"
    else
      redirect to "/"
    end
  end

  post "/doctors/new" do
  @doctor = current_user_doctor
    if params[:email] == "" || params[:last_name] == "" || params[:first_name] == ""
      flash[:message] = "**All fields must be filled in!**"
      redirect to "/doctors/new"
    else
      @patient = Patient.create(first_name: params[:first_name], last_name: params[:last_name], :email => params[:email], username: "#{params[:last_name]}#{params[:first_name]}", password: "password", doctor_id: @doctor.id)
      @patient.med_ids = params[:meds]
      @patient.save
      flash[:notice] = "**Successfully added patient #{@patient.last_name}, #{@patient.first_name}!**"
      redirect to "/doctors/#{@doctor.slug}/#{@patient.id}"
    end
  end

  get "/doctors/:slug/:id" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      @patient = Patient.find(params[:id])
      @meds = Med.all
      erb :"/doctors/show.html"
    else
      redirect to "/"
    end
  end

  # GET: /doctors/username/edit
  get "/doctors/:slug/:id/edit" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      @patient = Patient.find(params[:id])
      @meds = Med.all
      erb :"/doctors/edit.html"
    else
      redirect to "/"
    end
  end

  # PATCH: /doctors/username/id
  patch "/doctors/:slug/:id" do
    @patient = Patient.find(params[:id])
    @doctor = current_user_doctor
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
    @patient.med_ids = params[:meds]
    @patient.save
    flash[:update] = "**You've successfully updated your account information!**"
    redirect to "/doctors/#{@doctor.slug}/#{@patient.id}"
  end

  # DELETE: /doctors/username/id/delete
  delete "/doctors/:slug/:id/delete" do
    @patient = Patient.find(params[:id])
    @patient.delete
    redirect to "/doctors"
  end

  get "/doctors/:slug" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      @doctor = current_user_doctor
      erb :"/doctors/account.html"
    else
      redirect to "/"
    end
  end

  patch "/doctors/:slug" do
    @doctor = current_user_doctor
    if params[:first_name] == ""
      params[:first_name] = @doctor.first_name
    end

    if params[:last_name] == ""
      params[:last_name] = @doctor.last_name
    end

    if params[:email] == ""
      params[:email] = @doctor.email
    end

    @doctor.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    flash[:notice] = "**You've successfully updated your account information!**"
    redirect "/doctors/:slug"
  end

  # DELETE: /doctor/5/delete
  delete "/patients/:id/delete" do
    @doctor = Doctor.find(params[:id])
    @doctor.delete
    redirect "/logout"
  end

end
