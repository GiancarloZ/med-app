require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :welcome
  end

  get "/logout" do
    session.clear
    redirect to "/"
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

  end

end
