json.extract! order, :id, :order_sum, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)