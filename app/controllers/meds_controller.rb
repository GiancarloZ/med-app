class MedsController < ApplicationController

  # GET: /meds
  get "/meds" do
    if !logged_in? && Doctor.find_by(username: session[:username])
      redirect to "/"
    end
    @meds = Med.all
    erb :"/meds/index.html"
  end

  # GET: /meds/new
  get "/meds/new" do
    if !logged_in? && Doctor.find_by(username: session[:username])
      redirect to "/"
    end
    erb :"/meds/new.html"
  end

  # POST: /meds
  post "/meds" do
    @doctor = current_user_doctor
    if params[:name] == "" || params[:dosage] == ""
      flash[:error] = "**All fields must be filled in!**"
      redirect to "/meds/new"
    else
      @med = Med.create(name: params[:name], dosage: params[:dosage])
      flash[:notice] = "Successfully added medication #{@med.name}, #{@med.dosage}(mg)!"
      redirect to "/meds"
    end
  end

  # GET: /meds/5
  get "/meds/:id" do
    if !logged_in? && Doctor.find_by(username: session[:username])
      redirect to "/"
    end
    @med = Med.find(params[:id])
    erb :"/meds/show.html"
  end

  # GET: /meds/5/edit
  get "/meds/:id/edit" do
    if !logged_in? && Doctor.find_by(username: session[:username])
      redirect to "/"
    end
    @med = Med.find(params[:id])
    erb :"/meds/edit.html"
  end

  # PATCH: /meds/5
  patch "/meds/:id" do

    redirect "/meds/:id"
  end

  # DELETE: /meds/5/delete
  delete "/meds/:id/delete" do
    redirect "/meds"
  end

end
