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
    { user: { username: "Wolverine" } }
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

def get_contacts
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.html',

  ).to_s

  puts RestClient.get(url)
end

def create_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/contacts.json'
  ).to_s
  
  puts RestClient.post(
    url,
    { contact: { name: "Michaelangelo", 
      email: "cowabunga@gmail.com",
      user_id: 2 } }
  )
end

def destroy_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/contacts/3.html'
  ).to_s
  
  puts RestClient.delete(
    url
  )
end

def update_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: '3000',
  path: '/contacts/1.html'
  ).to_s
  
  puts RestClient.patch(
    url,
    { contact: { email: "life_is_but_a_stage@gmail.com"} }
  )
end

update_contact
