json.array!(@rights) do |right|
  json.extract! right, :id, :manage_rights
  json.extract! right, :id, :manage_users
  json.extract! right, :id, :manage_devices
  json.extract! right, :id, :manage_device_types
  json.extract! right, :id, :manage_stocks_and_units
  json.extract! right, :id, :manage_operations

  json.url right_url(right, format: :json)
end
