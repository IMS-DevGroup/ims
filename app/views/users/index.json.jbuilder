json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :active, :email, :prename, :lastname, :mobile_number, :info
  json.url user_url(user, format: :json)
end
