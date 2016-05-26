class HomeController < ApplicationController
  def index
    if session[:user_id] != nil
      redirect_to training_index_path
    end
  end
end
