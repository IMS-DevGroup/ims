json.array!(@stocks) do |stock|
  json.extract! stock, :id, :name, :info, :city, :street
  json.url stock_url(stock, format: :json)
end
