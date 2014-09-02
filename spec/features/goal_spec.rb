require 'rails_helper'

describe "goals" do

  let(:user_1) { User.create(username: "humbug", password: "scrooge") }
  let(:user_2) { User.create(username: "jayjay", password: "password") }
  let(:goal_1) { user_1.goals.create(
                    title: "Eat Pancakes",
                    description: "Eat one million pancakes",
                    private: false) }
  let(:goal_2) { user_1.goals.create(
                    title: "Take over the world",
                    description: "Steal all the pancakes",
                    private: true) }            
  let(:goal_3) { user_2.goals.create(
                    title: "Climb Mt. Everest",
                    description: "Practice hiking!",
                    private: true) }
  

  describe "creating goals" do
  
    before(:each) do
      sign_in_as(user_1)
      visit user_url(user_1)
    end
  
    it "has a new goal form on user show page" do
      expect(page).to have_content("Create new goal")
      expect(page).to have_field("Title")
      expect(page).to have_field("Description")
    end
  
    it "validates goals" do
      click_button "Add New Goal"
      expect(page).to have_content("Title can't be blank")
    end  
  
    it "only allows goal creation for current user" do
      visit user_url(user_2)
      expect(page).to_not have_button("Add New Goal")
    end
  
    it "doesn't allow duplicate goal titles for the same user" do
      goal_1
      fill_in "Title", with: "Eat Pancakes"
      click_button "Add New Goal"
      expect(page).to have_content("Title has already been taken")
    end
  
  end

  describe "viewing goals" do
  
    before(:each) do
      sign_in_as(user_1)
      goal_1
      goal_2
      goal_3
      visit user_url(user_1)
    end
  
    it "lists a user's goals on their page" do
      expect(page).to have_content("Eat Pancakes")
    end
  
    it "lists private goals for the current user" do
      expect(page).to have_content("Take over the world")
    end
  
    it "does not list private goals for other users" do
      visit user_url(user_2)
      expect(page).to_not have_content("Climb Mt. Everest")
    end
  
  end
  
  describe "deleting goals" do

    before(:each) do
      sign_in_as(user_1)
      goal_1
      goal_3
    end
  
    it "lets a user delete their goals" do
      visit user_url(user_1)
      click_button("Delete Goal")
      expect(page).to have_content("Create new goal")
      expect(page).not_to have_content("Eat Pancakes")
    end
  
    it "does not let a user delete another user's goals" do
      visit user_url(user_2)
      expect(page).not_to have_button("Delete Goal")
    end
  
  end


  describe "updating goals" do
  
    before (:each) do 
      sign_in_as(user_1)
      goal_1
      goal_3
    end
  
    it "lets a user update their goals" do
      visit user_url(user_1)
      click_link("Update Goal")
      fill_in "Title", with: "Eat All the Pancakes"
      click_button "Update Goal"
    
      expect(page).to have_content("Your Goal")
      expect(page).to have_content("Eat All the Pancakes")
    end
  
    it "does not let a user update another user's goals" do
      visit user_url(user_2)
      expect(page).to_not have_link("Update Goal")
    end
  
    it "does not let non-authors view goal edit page" do
      visit edit_goal_url(goal_3)
      expect(page).to have_content("Forbidden")
    end
  
    it "validates edited goals" do
      visit user_url(user_1)
      click_link("Update Goal")
      fill_in "Title", with: ""
      click_button "Update Goal"
    
      expect(page).to have_content("Title can't be blank")
    end
    
    it "can be marked as completed" do
      visit edit_goal_url(goal_1)
      check("Completed")
      click_button "Update Goal"
      
      expect(page).to have_content("Completed!")
    end

  end
end