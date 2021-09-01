module AuthHelper
  def create_user_and_session
    post users_model_registration, params: {
      data: {
        attributes: {
          email: 'test@test.com',
          password: 'test123'
        }
      }
    }, as: :json
  end
end
