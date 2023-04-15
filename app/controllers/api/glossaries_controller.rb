module Api
  class GlossariesController < ApplicationController
    # GET /glossaries
    def index
      glossaries = Glossary.all

      render(json: glossaries)
    end

    # GET /glossaries/:id
    def show
      glossary = Glossary.find(params[:id])

      render(json: glossary)
    end

    # POST /glossaries
    def create
      glossary = Glossary.create!(glossary_params)

      render(json: glossary, status: :created)
    end

    # POST /glossaries/:glossary_id/terms
    def terms
      term = Term.create!(term_params.merge(glossary_id: params[:glossary_id]))

      render(json: term, status: :created)
    end

    private

    def glossary_params
      params.require(:glossary).permit(:source_code, :target_code)
    end

    def term_params
      params.require(:term).permit(:source_term, :target_term)
    end
  end
end
