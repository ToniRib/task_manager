require_relative '../test_helper'

class UserCanCreateANewTask < FeatureTest
  def test_task_creation_with_valid_attributes
    # As a guest,
    # When I visit '/tasks/new'
    visit '/tasks/new'
    # And I add a title and description
    fill_in 'task[title]', with: 'Example Task'
    fill_in 'task[description]', with: 'Example Description'
    # And I click the submit button
    click_button 'Submit'
    # Then I should be redirected to '/tasks'
    assert_equal '/tasks', current_path
    # And I should see my new task title and description
    within 'section' do
      assert page.has_content? 'Example Task'
    end
  end
end
