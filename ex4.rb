class Person
  attr_accessor :tasks

  def initialize(tasks)
    raise 'tasks must be an array' unless tasks.is_a?(Array)
    @tasks = tasks
  end

  def completed_tasks
    tasks.select { |task| task.completed }
  end
end

class Tasks
  attr_accessor :name, :completed

  def initialize(name, completed)
    @name = name
    @completed = completed
  end

  def to_s
    "#{name} (#{completed})"
  end
end


task1 = Tasks.new('ex. 1', true)
task2 = Tasks.new('ex. 2', false)
task3 = Tasks.new('ex. 3', true)
task4 = Tasks.new('ex. 4', false)
task5 = Tasks.new('ex. 5', false)
task6 = Tasks.new('ex. 6', true)

puts Person.new([task1, task2, task3, task4, task5, task6]).completed_tasks
