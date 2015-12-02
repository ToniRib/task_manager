require_relative '../test_helper'

class UserCanDeleteAnExistingTask < FeatureTest
  def test_existing_task_is_deleted_successfully
    TaskManager.create({ title: 'Original Title',
                         description: 'Original Description' })

    # As a guest,
    # When I visit '/tasks'
    visit '/tasks'
    # And I click on the delete button for a tasks
    click_button 'delete'
    # Then I no longer see the task information
    within 'article' do
      refute page.has_content? 'Original Title'
    end
  end
end
