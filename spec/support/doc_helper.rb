module DocHelper
  def generate_response_examples(example, response)
    content = example.metadata.try(:response).try(:content) || {}
    example_spec = {
      'application/json' => {
        example: response.body.present? ? JSON.parse(response.body, symbolize_names: true) : ''
      }
    }
    example.metadata[:response][:content] = content.deep_merge(example_spec)
  end
end
