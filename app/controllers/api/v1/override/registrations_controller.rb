module Api
  module V1
    module Override
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        def sign_up_params
         {
            first_name: params['data']['attributes']['first_name'],
            last_name: params['data']['attributes']['last_name'],
            email: params['data']['attributes']['email'],
            password: params['data']['attributes']['password']
          }
        end

        def account_update_params
          {
            first_name: params['data']['attributes']['first_name'],
            last_name: params['data']['attributes']['last_name'],
          }
        end

        def render_create_success
          render json: Users::Representers::Single.new(resource_data).call 
        end

        def render_update_success
          render json: Users::Representers::Single.new(resource_data).call 
        end

        def render_destroy_success
          render head: :no_content
        end
      end
    end
  end
end
