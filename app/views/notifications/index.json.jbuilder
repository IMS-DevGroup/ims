json.array!(@notifications) do |notification|
  json.extract! notification, :id, :subject, :info, :checked
  json.url notification_url(notification, format: :json)
end
