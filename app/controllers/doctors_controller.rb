class DoctorsController < ApplicationController

  # GET: /doctors/signup
  get "/doctors/signup" do
    erb :"/doctors/signup.html"
  end

  # POST: /doctors/signup
  post "/doctors/signup" do
    redirect "/doctors/login.html"
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

  # POST: /doctors
  post "/doctors" do
    redirect "/doctors"
  end

  # GET: /doctors/5
  get "/doctors/:id" do
    erb :"/doctors/show.html"
  end

  # GET: /doctors/5/edit
  get "/doctors/:id/edit" do
    erb :"/doctors/edit.html"
  end

  # PATCH: /doctors/5
  patch "/doctors/:id" do
    redirect "/doctors/:id"
  end

  # DELETE: /doctors/5/delete
  delete "/doctors/:id/delete" do
    redirect "/doctors"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Doctor.find(session[:user_id])
    end
  end
end
