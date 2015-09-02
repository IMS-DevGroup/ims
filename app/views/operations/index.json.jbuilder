json.array!(@operations) do |operation|
  json.extract! operation, :id, :number, :type, :info, :location, :close_date
  json.url operation_url(operation, format: :json)
end
