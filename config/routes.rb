Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  authenticated do
    root to: 'dashboard#index', as: :authenticated_root
  end
  
  root 'home#index'

  resources :subjects do
    resources :exams, only: %i[new create show] do
      resources :answers, only: :create do
        member do
          get :results
        end
      end
    end
    resources :documents, only: %i[index create destroy]
    member do
      get :conference
    end
  end

  resources :subject_enrolleds do
    collection do
      get :view
      patch :enroll
    end

    member do
      patch :approve
    end
  end
end
