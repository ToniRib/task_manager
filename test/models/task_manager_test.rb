require_relative '../test_helper'
require 'pry'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description" })

    task = TaskManager.find(1)

    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_finds_all_tasks
    tasks = [{ :title => "task1", :description => "description1" },
             { :title => "task2", :description => "description2" },
             { :title => "task3", :description => "description3" }]

    tasks.each { |task| TaskManager.create(task) }

    assert_equal 3, TaskManager.all.count
    TaskManager.all.each_with_index do |task, i|
      assert_equal Task, task.class
      assert_equal tasks[i][:title], task.title
      assert_equal tasks[i][:description], task.description
    end
  end

  def test_it_finds_a_specific_task
    tasks = [{ :title => "task1", :description => "description1" },
             { :title => "task2", :description => "description2" },
             { :title => "task3", :description => "description3" }]

    tasks.each { |task| TaskManager.create(task) }

    1.upto(3) do |i|
      assert_equal i, TaskManager.find(i).id
      assert_equal "task#{i}", TaskManager.find(i).title
      assert_equal "description#{i}", TaskManager.find(i).description
    end
  end

  def test_it_updates_a_task_record
    tasks = [{ :title => "task1", :description => "description1" },
             { :title => "task2", :description => "description2" },
             { :title => "task3", :description => "description3" }]

    tasks.each { |task| TaskManager.create(task) }

    new_data = { :title => "task2_v2.0",
                 :description => "description2_v2.0" }
    TaskManager.update(2, new_data)

    updated_task = TaskManager.find(2)
    assert_equal new_data[:title], updated_task.title
    assert_equal new_data[:description], updated_task.description

    1.upto(3) do |i|
      next if i == 2

      assert_equal i, TaskManager.find(i).id
      assert_equal "task#{i}", TaskManager.find(i).title
      assert_equal "description#{i}", TaskManager.find(i).description
    end
  end

  def test_it_deletes_a_task_record
    tasks = [{ :title => "task1", :description => "description1" },
             { :title => "task2", :description => "description2" },
             { :title => "task3", :description => "description3" }]

    tasks.each { |task| TaskManager.create(task) }

    TaskManager.delete(2)

    assert_equal 2, TaskManager.all.count
    assert_equal tasks[0][:title], TaskManager.all[0].title
    assert_equal tasks[2][:title], TaskManager.all[1].title
  end
end
