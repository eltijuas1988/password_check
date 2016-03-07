class PasswordController < ApplicationController
  # Method that will run the checks on user and pass
  def check
    # if params that hold either user or pass are empty...
    if params[:userid].nil? || params[:password].nil?

      # ...Instance variables below will equal messages that will ask user to put user id and password. These will display on the screen
      @userid_validations = "enter user id"
      @password_validations = "enter password"

    # If params have values
    else

      #The params will be stored in instance variables in order to access them easier
      @userid = params[:userid]
      @password = params[:password]

      #The methods below will run and check the instance variables @userid and password for validity
      userid_validations
      password_validations

      #An object will be created in order to store a user name and password into the database
      @user = User.new

      #If user id is valid
      if @userid_validations == "Your user id is valid."
        #The object created above will call method name and store @userid in preparation to migrate into database
        @user.name = @userid

        #In order to display user name in case password is not valid and need to enter it again, user name will be stored inside @userid
        @userid = @user.name.to_s
      end

      #If password is valid
      if @password_validations == "Your password is valid."
        #User.password will store the valid @password variable
        @user.password = @password
      end

      #Since the only way to store values inside @user name and password was for them to be valid, IF they both contain something...
      if !@user.name.nil? && !@user.password.nil?
        #...then the user will be saved into the database with the name and password
        @user.save
        #Store values on session in order to have them cross over to welcome controller. IF they are not stored in sessions, they cannot cross over to other controllers and will not be able to display on that page
        session[:user_name] = @user.name.to_s
        session[:user_password] = @user.password.to_s

        #Redirect to next page
        redirect_to '/welcome/accept'
      end

    #Close if/else statement that stores user id and passeword if they dont have any values
    end
  #Close method that will run as soon as website opens
  end

  #Method that runs inside the check method and verifies if userid is correct
  def userid_validations
    #If user id is shorter that 6 chars
    if @userid.length < 6
      #Store message inside variable that will display on page and used inside the check method
      @userid_validations = "User id has to be at least 6 characters."

    #If userid includes chars such as: !, $ or #...
    elsif @userid.include?("!") || @userid.include?("$") || @userid.include?("#")
      #User id messge will be invalid
      @userid_validations = "User ID cannot contain !, $ or # symbols."

    #If all attemps above to weed out undesired input are cleared, then the message will pass.
    else
      @userid_validations = "Your user id is valid."
    end
  end

  #Method that will check if password is valid and will be used inside 'check' method to evaluate answer
  def password_validations
    #If password is too short...
    if @password.length < 6
      #Message returned inside varible will be a fail
      @password_validations = "Password has to be at least 6 characters."
    #If password DOES NOT include !, $ or #...
    elsif !@password.include?("!") && !@password.include?("$") && !@password.include?("#")
      #Message returned inside variable will ask user to have at least one
      @password_validations = "Password must contain at least !, $ or # symbols."
    #The following will check for letters by evaluating upcased to downcased string. If they are the same, then it doesnt contain letters because you cannot upcase or downcase numbers
    elsif @password.upcase == @password.downcase
      #Will return fail message
      @password_validations = "Your password must contain at least one letter"

    #If all attempts above to weed out invalid answers pass...
    else
      #Return message that passes
      @password_validations = "Your password is valid."
    end
  #Closes password_validations method
  end
#Closes Class
end
