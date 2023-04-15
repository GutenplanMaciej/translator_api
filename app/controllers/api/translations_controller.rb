module Api
  class TranslationsController < ApplicationController
    # GET /translations/:id
    def show
      translation = Translation.includes(:glossary).find(params[:id])

      highlighted_text, occurrences = Api::Translations::Show.new(translation).call

      render(json: translation, highlighted_text:, occurrences:)
    end

    # POST /translations
    def create
      translation = Api::Translations::Create.new(translation_params).call

      render(json: translation, status: :created)
    end

    private

    def translation_params
      params.require(:translation).permit(:source_language_code, :target_language_code, :source_text, :glossary_id)
    end
  end
end
