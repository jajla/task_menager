import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String status) {
              Provider.of<TaskProvider>(context, listen: false)
                  .filterTasksByStatus(status);
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Completed', 'Pending'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              Task task = taskProvider.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Due: ${task.dueDate}'),
                trailing: Text(task.status),
                onTap: () {
                  // Możesz dodać funkcję edytowania zadania
                },
                onLongPress: () {
                  // Funkcja usuwania zadania
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Task'),
                        content: Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Provider.of<TaskProvider>(context, listen: false)
                                  .deleteTask(task.id!);
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Dialog do dodawania nowego zadania
  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController dueDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
              TextField(
                controller: dueDateController,
                decoration: InputDecoration(labelText: 'Due Date (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  category: 'General', // Domyślna kategoria
                  priority: 'Low', // Domyślna priorytet
                  dueDate: dueDateController.text,
                  status: 'pending', // Domyślny status
                );
                Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                Navigator.of(context).pop();
              },
              child: Text('Add Task'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
