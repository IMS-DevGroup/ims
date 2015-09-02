json.array!(@rights) do |right|
  json.extract! right, :id, :manage_rights
  json.url right_url(right, format: :json)
end
