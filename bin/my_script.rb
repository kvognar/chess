require 'addressable/uri'
require 'rest-client'

def get_users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html',
    query_values: {
    
    } 
  ).to_s

  puts RestClient.get(url)
end

def create_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/users.json'
  ).to_s
  
  puts RestClient.post(
    url,
    { user: { name: 'Frankenstein', email: "shelley@gmail.com" } }
  )
end

def destroy_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/users/5.html'
  ).to_s
  
  puts RestClient.delete(
    url
    # { user: { id: 5} }
  )
end

def update_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/users/4.html'
  ).to_s
  
  puts RestClient.patch(
    url,
    { user: { email: "optimusprime@gmail.com"} }
  )
end

update_user