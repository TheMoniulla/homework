class ToDoList
  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def add_task(task)
    @tasks.push(task)
  end

  def remove_task(index)
    @tasks.delete(tasks[index])
  end

  def tasks_for_display
    tasks.each { |task| puts task }
  end

  def load_from_file(file)
    File.open(file).each_line do |line|
      task = Task.new(line.strip)
      add_task(task)
    end
  end

  def save_task_to_file(file)
    File.open(file, 'w') { |f| f.write(tasks.join("\n")) }
  end
end

class Task < Struct.new(:text)
  def to_s
    text
  end
end

to_do_list = ToDoList.new
to_do_list.load_from_file('to_do.txt')
to_do_list.tasks_for_display
puts "_______________________"
to_do_list.add_task(Task.new('Bake muffins!'))
to_do_list.tasks_for_display
puts "_______________________"
to_do_list.remove_task(2)
to_do_list.tasks_for_display
to_do_list.save_task_to_file('to_do2.txt')
