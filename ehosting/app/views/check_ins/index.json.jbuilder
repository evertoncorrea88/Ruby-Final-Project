json.array!(@check_ins) do |check_in|
  json.extract! check_in, :id, :host_id, :guest_id, :date_in, :date_out
  json.url check_in_url(check_in, format: :json)
end
