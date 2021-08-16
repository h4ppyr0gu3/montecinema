module Api
	module V1
		module Users
			class SessionsController < ApplicationController

				def create
			    user = User.find_by(params[:email])
			    if user && user.authenticate(params[:password])
			      session[:user_id] = user.id
			      redirect_to root_url, notice: "Logged in!"
			    else
			      flash.now[:alert] = "Email or password is invalid"
			      render "new"
			    end
			  end

				def update
				end

				private

				def session_params
					params.require(:user).permit(:email, :password, :name)
				end
			end
		end
	end
end