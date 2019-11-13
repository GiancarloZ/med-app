class PatientsController < ApplicationController

  # GET: /doctors/signup
  get "/patients/signup" do
    erb :"/patients/signup.html"
  end

  # POST: /doctors/signup
  post "/patients/signup" do
    redirect "patients/login.html"
  end

  # GET: /doctors/login
  get "/patients/login" do
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

  # POST: /patients
  post "/patients" do
    redirect "/patients"
  end

  # GET: /patients/5
  get "/patients/:id" do
    erb :"/patients/show.html"
  end

  # GET: /patients/5/edit
  get "/patients/:id/edit" do
    erb :"/patients/edit.html"
  end

  # PATCH: /patients/5
  patch "/patients/:id" do
    redirect "/patients/:id"
  end

  # DELETE: /patients/5/delete
  delete "/patients/:id/delete" do
    redirect "/patients"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Patient.find(session[:user_id])
    end
  end
end
