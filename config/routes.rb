Rails.application.routes.draw do
  resources :leases, only: [:index, :show, :create, :destroy, :tenant_id, :apartment_id]
  resources :tenants
  resources :apartments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
