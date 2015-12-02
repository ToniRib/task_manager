require_relative '../test_helper'

class UserCanEditAnExistingTask < FeatureTest
  def test_existing_task_is_updated_with_new_information
    TaskManager.create({ title: 'Original Title',
                         description: 'Original Description' })

    visit '/tasks/1/edit'

    fill_in 'task[title]', with: 'Updated Title'
    fill_in 'task[description]', with: 'Updated Description'
    click_button 'Submit'

    assert_equal '/tasks/1', current_path
    within 'h2' do
      assert page.has_content? 'Updated Title'
    end
    within 'h5' do
      assert page.has_content? 'Updated Description'
    end
  end
end
