module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController

        def create
          user = user.new(registration_params)
          if user.save
            render json: user, status: :created
          else
            render json: user.errors, status: :bad_request
          end
        end

        def update
        end

        def destroy
          current_user.destroy
          render head: :no_content
        end

        private

        def registration_params
          params.require(:user).permit(:name, :email, :password)
        end
      end
    end
  end
end