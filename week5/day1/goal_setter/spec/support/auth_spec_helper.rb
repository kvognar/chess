def sign_up_as_humbug(log_out = true)
  visit new_user_url
  fill_in "Username", with: "humbug"
  fill_in "Password", with: "password"
  click_button "Sign Up"
  click_button "Sign Out" if log_out
end

def sign_in_as_humbug
  visit new_session_url
  fill_in "Username", with: "humbug"
  fill_in "Password", with: "password"
  click_button "Sign In"
end