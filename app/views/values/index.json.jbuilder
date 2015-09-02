json.array!(@values) do |value|
  json.extract! value, :id, :value
  json.url value_url(value, format: :json)
end
