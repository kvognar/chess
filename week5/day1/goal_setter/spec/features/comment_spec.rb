require 'rails_helper'

describe "comments" do
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
                    
  before(:each) do
    goal_1
    goal_2
    goal_3
    sign_in_as(user_2)
  end                  


  describe "making comments" do
    
    
    describe "comments on users" do
      it "has a comment form on user pages" do
        visit user_url(user_1)
        expect(page).to have_field("Comment")
      end
      
      it "publishes comments from other users" do
        visit user_url(user_1)
        fill_in "Comment", with: "Good job!"
        click_button "Submit"
        expect(page).to have_content("Good job!")
      end
      
      it "allows comments on self" do
        visit user_url(user_2)
        fill_in "Comment", with: "Yeah, I rock"
        click_button "Submit"
        expect(page).to have_content("Yeah, I rock")
      end
    end
    
    describe "comments on goals" do
      it "has a comment form on goal page" do
        visit goal_url(goal_1)
        expect(page).to have_field("Comment")
      end
      
      it "publishes comments from other users" do
        visit goal_url(goal_1)
        fill_in "Comment", with: "Good job!"
        click_button "Submit"
        expect(page).to have_content("Good job!")
      end
      
      it "allows comments on self" do
        visit goal_url(goal_3)
        fill_in "Comment", with: "Yeah, I rock"
        click_button "Submit"
        expect(page).to have_content("Yeah, I rock")
      end
        
    end
    
  end
  
  
  
end