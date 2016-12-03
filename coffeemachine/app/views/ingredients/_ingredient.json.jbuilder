json.extract! ingredient, :id, :name, :amount_left, :price, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)