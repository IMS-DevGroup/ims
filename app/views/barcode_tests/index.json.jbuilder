json.array!(@barcode_tests) do |barcode_test|
  json.extract! barcode_test, :id, :device_id
  json.url barcode_test_url(barcode_test, format: :json)
end
