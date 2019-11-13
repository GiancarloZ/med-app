class MedsController < ApplicationController

  # GET: /meds
  get "/meds" do
    erb :"/meds/index.html"
  end

  # GET: /meds/new
  get "/meds/new" do
    erb :"/meds/new.html"
  end

  # POST: /meds
  post "/meds" do
    redirect "/meds"
  end

  # GET: /meds/5
  get "/meds/:id" do
    erb :"/meds/show.html"
  end

  # GET: /meds/5/edit
  get "/meds/:id/edit" do
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
