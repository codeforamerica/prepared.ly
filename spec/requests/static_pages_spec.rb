require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Prepared.ly'" do
      visit root_path
      page.should have_content('Prepared.ly')
    end
  end

  describe "About page" do

    it "should have the content 'About'" do
      visit about_path
      page.should have_content('About')
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "Prepared.ly | Contact")
    end
  end
end
# didn't put one in for the Help page - fix to match Listing 5.19

