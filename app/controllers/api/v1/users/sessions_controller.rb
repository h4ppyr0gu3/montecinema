module Api
  module V1
    module Users
      class SessionsController < ApplicationController
        skip_before_action :authenticate_user, only: %i[create]

        def create
          user = find_user
          if user&.authenticate(session_deserializer[:password])
            response.set_header('Authorization',
                                "Bearer #{JsonWebToken.encode(jti: user.jti.jti)}")
            render jsonapi: user
          else
            render jsonapi_errors: { user: 'Doesn\'t exist' }, status: :bad_request
          end
        end

        def destroy
          current_user.jti.destroy
          render head: :no_content
        end

        private

        def session_deserializer
          {
            email: params['data']['attributes']['email'],
            first_name: params['data']['attributes']['first_name'],
            last_name: params['data']['attributes']['last_name'],
            password: params['data']['attributes']['password']
          }
        end

        def find_user
          possible_user = User.where(email: session_deserializer[:email])
          if possible_user.count < 1
            nil
          else
            possible_user.first
          end
        end
      end
    end
  end
end
