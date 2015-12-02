require_relative '../test_helper'

class UserSeesGreetingOnHomepage < FeatureTest
  def test_greeting_is_displayed
    # As a guest,
    # When I visit the homepage (/),
    visit '/'
    # Then I see the 'Welcome to the TaskManager' greeting
    within '#greeting' do
      assert page.has_content? 'Welcome to the TaskManager'
    end
  end
end
