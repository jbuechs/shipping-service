Rails.application.routes.draw do
  post '/ups_rates', to: 'shipping#ups_rates'
  post '/fedex_rates', to: 'shipping#fedex_rates'
end
