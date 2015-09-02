json.array!(@devices) do |device|
  json.extract! device, :id, :ready, :info, :owner_id
  json.url device_url(device, format: :json)
end
