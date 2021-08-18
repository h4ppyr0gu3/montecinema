module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController
        skip_before_action :authenticate_user, only: %i[create]

        def create
          user = User.new(registration_deserializer)
          if user.save
            response.set_header('Authorization', "Bearer #{JsonWebToken.encode(user_id: user.id)}")
            render jsonapi: user, status: :created
          else
            render jsonapi_errors: user.errors, status: :bad_request
          end
        end

        def show 
          render jsonapi: current_user
        end

        def update
          user = User.find(params[:id])
          if user.update(registration_deserializer)
            render jsonapi: user, status: :accepted
          else
            render jsonapi_errors: user.errors, status: :bad_request
          end
        end

        def destroy
          current_user.destroy
          render head: :no_content
        end

        private

        def registration_deserializer
          {
            first_name: params['data']['attributes']['first_name'],
            last_name: params['data']['attributes']['last_name'],
            email: params['data']['attributes']['email'],
            password: params['data']['attributes']['password']
          }
          
        end
      end
    end
  end
end