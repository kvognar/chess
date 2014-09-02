require 'rails_helper'

describe "the signup process" do
  before(:each) { visit new_user_url }
  
  it "has a new user page" do
    expect(page).to have_field("Username")
    expect(page).to have_field("Password")
    expect(page).to have_button("Sign Up")
  end
    
  it "requires a username" do
    fill_in "Password", with: "password"
    click_button "Sign Up"
    expect(page).to have_content("Username can't be blank")
  end
  
  it "requires password" do
    fill_in "Username", with: "humbug"
    click_button "Sign Up"
    expect(page).to have_content("Password is too short")
  end
    
  it "shows username on the homepage after signup" do
    fill_in "Username", with: "humbug"
    fill_in "Password", with: "password"
    click_button "Sign Up"
    expect(page).to have_content("Welcome humbug")
  end
  
end

describe "logging in" do
  
  before(:each) do 
    sign_up_as_humbug
    visit new_session_url
  end 
  
  it "requires a username" do
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(page).to have_content("Invalid username/password combination")
  end
  
  it "requires password" do
    fill_in "Username", with: "humbug"
    click_button "Sign In"
    expect(page).to have_content("Invalid username/password combination")
  end
  
  it "rejects invalid credentials" do
    fill_in "Username", with: "humbug"
    fill_in "Password", with: "blatherskites"
    click_button "Sign In"
    
    expect(page).to have_content("Invalid username/password combination")
    expect(page).to_not have_content("Welcome humbug")
  end
  
  
  it "shows username on the homepage after login" do
    fill_in "Username", with: "humbug"
    fill_in "Password", with: "password"
    click_button "Sign In"
    
    expect(page).to have_content("Welcome humbug")
  end
  
  it "should redirect if already signed in" do
    sign_in_as_humbug
    visit new_session_url
    expect(page).to_not have_content("Sign In")
  end
  
  
end

describe "logging out" do
  
  before(:each) { sign_up_as_humbug }
  
  it "begins with logged out state" do
    visit user_url(User.first)
    expect(page).to have_content("Sign In")
  end
  
  it "doesn't show username on the homepage after logout" do
    sign_in_as_humbug
    click_button "Sign Out"
    expect(page).not_to have_content("Welcome humbug")
  end
  
end