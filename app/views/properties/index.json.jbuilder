json.array!(@properties) do |property|
  json.extract! property, :id, :name, :info
  json.url property_url(property, format: :json)
end
