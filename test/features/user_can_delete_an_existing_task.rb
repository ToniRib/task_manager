require_relative '../test_helper'

class UserCanDeleteAnExistingTask < FeatureTest
  def test_existing_task_is_deleted_successfully
    TaskManager.create({ title: 'Original Title',
                         description: 'Original Description' })

    visit '/tasks'

    click_button 'delete'

    within 'article' do
      refute page.has_content? 'Original Title'
    end
  end
end
