module Api
  module Translations
    class Create
      def initialize(params)
        @params = params
        @source_language_code = params[:source_language_code].downcase
        @target_language_code = params[:target_language_code].downcase
      end

      def call
        validate_codes if glossary
        Translation.create!(@params)
      end

      private

      def validate_codes
        raise LanguageCodesError if glossary[:source_code] != @source_language_code && glossary[:target_code] != @target_language_code
      end

      def glossary
        @glossary ||= Glossary.find(@params[:glossary_id]) if @params[:glossary_id].present?
      end
    end
  end
end
