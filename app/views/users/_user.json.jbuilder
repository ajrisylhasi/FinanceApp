json.extract! user, :id, :name, :numri_fiskal, :numri_biznesit, :numri_tvsh, :password_digest, :created_at, :updated_at
json.url user_url(user, format: :json)
