Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/webhooks/telegram_Ymn0xHHAp2BPyQ_IiVETBw' => 'webhooks#callback'
  get 'webhooks/index' => 'webhooks#index'
  root 'webhooks#index'
end
