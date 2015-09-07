json.array!(@lendings) do |lending|
  json.extract! lending, :id, :receive, :lending_info, :receive_info
  json.url lending_url(lending, format: :json)
end
