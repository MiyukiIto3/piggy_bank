json.extract! post, :id, :user_id, :kid_id, :date, :type, :amount, :description, :created_at, :updated_at
json.url post_url(post, format: :json)
