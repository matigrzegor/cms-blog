class ApplicationController < ActionController::Base

    rescue_from ActiveRecord::RecordNotFound do
        render json: NotFoundErrorSerializer.new.serializable_hash,
                     status: 404
    end

    rescue_from ActiveRecord::RecordInvalid do
        render json: BadRequestErrorSerializer.new.serializable_hash,
                     status: 400
    end

end
