module Api
  module Translations
    class Show
      def initialize(translation)
        @translation = translation
        @terms = translation&.terms
      end

      def call
        return [nil, nil] if @terms.blank?

        occurrences = []
        highlighted_text = source_text

        @terms.each do |term|
          if source_text.include?(term.source_term)
            occurrences << term.source_term
            highlighted_text = source_text.gsub(term.source_term, "<HIGHLIGHT> #{term.source_term} </HIGHLIGHT>")
          end
        end

        [highlighted_text, occurrences]
      end

      private

      def source_text
        @source_text ||= @translation.source_text
      end
    end
  end
end
