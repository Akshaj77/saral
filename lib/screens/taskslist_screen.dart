import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saral/business_logic/bloc/task_bloc.dart';
import 'package:saral/widget/addtask.dart';

class UpdateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskForm()));
        },
        tooltip: 'Add a new task',
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return Center(child: Text('No tasks available.', style: TextStyle(fontSize: 18)));
              }
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
                    direction: DismissDirection.endToStart ,
                    onDismissed: (direction) {
                      context.read<TaskBloc>().add(DeleteTask(id: task.id.toString()));
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Icon(Icons.task, color: task.attributes.Completed ? Colors.green : Colors.red),
                        title: Text(
                          task.attributes.Title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: task.attributes.Completed ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(task.attributes.Description),
                        trailing: Checkbox(
                          value: task.attributes.Completed,
                          onChanged: (value) {
                            context.read<TaskBloc>().add(ToggleTaskCompletion(task.id.toString(), value!));
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TaskError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}', style: TextStyle(fontSize: 18, color: Colors.red)),
                  const  SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(TaskLoad());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
