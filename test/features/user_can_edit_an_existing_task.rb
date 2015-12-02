require_relative '../test_helper'

class UserCanEditAnExistingTask < FeatureTest
  def test_existing_task_is_updated_with_new_information
    TaskManager.create({ title: 'Original Title',
                         description: 'Original Description' })

    # As a guest,
    # When I visit '/tasks/:id/edit'
    visit '/tasks/1/edit'
    # And I enter a new task title
    fill_in 'task[title]', with: 'Updated Title'
    # And I enter a new task description
    fill_in 'task[description]', with: 'Updated Description'
    # And I click the submit button
    click_button 'Submit'
    # Then I am redirected to '/tasks/:id'
    assert_equal '/tasks/1', current_path
    # And I see the updated task title and description
    within 'h2' do
      assert page.has_content? 'Updated Title'
    end
    
    within 'h5' do
      assert page.has_content? 'Updated Description'
    end
  end
end
