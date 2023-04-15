Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    defaults format: :json do
      resources :glossaries, only: %i[index show create] do
        post :terms
      end

      resources :translations, only: %i[show create]
    end
  end
end
