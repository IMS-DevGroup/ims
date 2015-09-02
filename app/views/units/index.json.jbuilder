json.array!(@units) do |unit|
  json.extract! unit, :id, :name, :info, :phone_number
  json.url unit_url(unit, format: :json)
end
