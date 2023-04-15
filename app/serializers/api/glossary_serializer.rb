module Api
  class GlossarySerializer < ActiveModel::Serializer
    attributes :id, :source_code, :target_code, :terms
  end
end
