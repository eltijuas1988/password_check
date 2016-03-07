class WelcomeController < ApplicationController
  #Method that executes once user and password are valid
  def accept
    #Take user name and passwod that are currently in sessions and convert them into instance variables for cleaner code on the hmtl side
    @userid = session[:user_name]
  end
end
