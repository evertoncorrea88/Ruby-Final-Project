json.array!(@hosts) do |host|
  json.extract! host, :id, :name, :room, :email, :phone
  json.url host_url(host, format: :json)
end
