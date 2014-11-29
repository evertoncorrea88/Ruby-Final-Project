json.array!(@guests) do |guest|
  json.extract! guest, :id, :name, :email, :phone
  json.url guest_url(guest, format: :json)
end
