Rails.application.routes.draw do
  get '/ups_rates', to: 'shipping#ups_rates'
  get '/fedex_rates', to: 'shipping#fedex_rates'
end
