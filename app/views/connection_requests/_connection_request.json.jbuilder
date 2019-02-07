json.extract! connection_request, :id, :requester_id, :requestee_id, :created_at, :updated_at
json.url connection_request_url(connection_request, format: :json)
