function Person(tasks) {
    if (!(tasks instanceof Array)) {
        throw 'tasks must be an Array'
    }

    this.tasks = tasks;
};

Person.prototype.completedTasks = function () {
    return this.tasks.filter(function (task) {
        return task.completed
    }).join("\n")
};

function Tasks(name, completed) {
    this.name = name;
    this.completed = completed;
};

Tasks.prototype.toString = function () {
    return this.name + ' (' + this.completed + ')'
};

var task1 = new Tasks('ex. 1', true);
var task2 = new Tasks('ex. 2', false);
var task3 = new Tasks('ex. 3', true);
var task4 = new Tasks('ex. 4', false);
var task5 = new Tasks('ex. 5', false);
var task6 = new Tasks('ex. 6', true);

console.log(new Person([task1, task2, task3, task4, task5, task6]).completedTasks());
