Rails.application.routes.draw do
  # POST /metric/{key}: Crea o actualiza un valor asociado a una clave específica
  post '/metric/:key', to: 'metrics#create'

  # DELETE /metric/{key}: Elimina todas las métricas asociadas con una clave
  delete '/metric/:key', to: 'metrics#destroy'

  # GET /metrics: Recupera todas las métricas agregadas por clave de la última hora
  get '/metrics', to: 'metrics#index'
end
