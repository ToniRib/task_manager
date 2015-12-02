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
end
