json.extract! user, :id, :name, :password, :money_left, :created_at, :updated_at
json.url user_url(user, format: :json)