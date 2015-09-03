json.array!(@starts) do |start|
  json.extract! start, :id, :title, :notes
  json.url start_url(start, format: :json)
end
