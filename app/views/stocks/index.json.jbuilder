json.array!(@stocks) do |stock|
  json.extract! stock, :id, :name, :info
  json.url stock_url(stock, format: :json)
end
