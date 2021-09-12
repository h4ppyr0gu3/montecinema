class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::ActiveRecordError do |e|
      Rails.logger.error(
        "#{e.message}\n#{e.backtrace[0, 10].join("\n\t")}"
      )
      if e.instance_of?(ActiveRecord::RecordNotFound)
        status = :not_found
        error = 'Record doesn\'t exist'
      elsif e.instance_of?(ActiveRecord::NotNullViolation)
        status = :bad_request
        error = 'value can\'t be null'
      else
        status = :bad_request
        error = e.message
      end
      render json: { type: e.class, error: error }, status: status
    end
  end
end
