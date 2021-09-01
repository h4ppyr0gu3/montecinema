# frozen_string_literal: true

namespace :api do
  desc 'generate api docs with swagger'
  task docs: :environment do
    system("rake rswag:specs:swaggerize")
  end
end