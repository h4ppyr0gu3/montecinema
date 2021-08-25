module Api
  module V1
    module Override
      class SessionsController < DeviseTokenAuth::SessionsController 
        def render_create_success
          render json: Users::Representers::Single.new(resource_data).call
        end

        def render_destroy_success
          render head: :no_content
        end

        def resource_params
          {
            email: params['data']['attributes']['email'],
            first_name: params['data']['attributes']['first_name'],
            last_name: params['data']['attributes']['last_name'],
            password: params['data']['attributes']['password']
          }
        end
      end
    end
  end
end
