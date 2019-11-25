require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash, :sweep => true
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      redirect to "/doctors"
    elsif logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      redirect to "/patients"
    end
    erb :welcome
  end

  get "/logout" do
    session.clear
    redirect to "/"
  end

  get "/accounts" do
    if logged_in? && !!Patient.find_by(id: session[:user_id], username: session[:username])
      redirect to "/patients/edit"
    elsif logged_in? && !!Doctor.find_by(id: session[:user_id], username: session[:username])
      redirect to "/doctors/account"
    else
      redirect to "/"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id] && !!session[:username]
    end

    def current_user_doctor
      Doctor.find_by(id: session[:user_id], username: session[:username])
    end

    def current_user_patient
      Patient.find_by(id: session[:user_id], username: session[:username])
    end

    def redirect_if_doctor_not_logged_in
      if !logged_in? || !Patient.find_by(id: session[:user_id], username: session[:username])
        redirect to "/"
      end
    end
  end

end
