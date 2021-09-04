module UseCase
	class Base
		def self.call(params:)
	    new(params: params).call
	  end

	  def initialize(params:)
	    @params = params
	  end

	  def call
	    ActiveRecord::Base.transaction do
	      persist.tap do
		    rescue Exception => e
		    	Rails.logger.error(
		        e.message + "\n" + e.backtrace[0, 10].join("\n\t")
		      )
			  	render json: {type: e.class, error: e.message}, status: :bad_request
			  end
		  end
	  end

	  private

	  attr_reader :params
	end
end