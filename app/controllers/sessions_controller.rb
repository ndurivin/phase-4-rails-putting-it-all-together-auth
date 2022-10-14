class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
        else
            not_authorised
        end
    end

    def destroy
    
       if session.delete :user_id
        head :no_content
       else
        not_authorised
       end
        
      
    end

    private

    def not_authorised
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
end
