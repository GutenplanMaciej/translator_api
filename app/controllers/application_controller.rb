class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ArgumentError, with: :handle_bad_request
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_uniq_record
  rescue_from ActionController::ParameterMissing, with: :handle_bad_request
  rescue_from LanguageCodesError, with: :handle_bad_request

  private

  def handle_record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def handle_record_invalid(error)
    render json: { error: error.record&.errors&.full_messages }, status: :unprocessable_entity
  end

  def handle_bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end

  def handle_uniq_record(_)
    render json: { error: I18n.t('glossary.validation_messages.codes') }, status: :bad_request
  end
end
