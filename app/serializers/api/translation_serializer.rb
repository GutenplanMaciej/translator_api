module Api
  class TranslationSerializer < ActiveModel::Serializer
    attributes :id, :source_language_code, :target_language_code, :source_text, :glossary, :highlighted_text, :occurrences

    def highlighted_text
      @instance_options[:highlighted_text]
    end

    def occurrences
      @instance_options[:occurrences]
    end
  end
end
