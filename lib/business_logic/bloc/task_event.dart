part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class PublishTask extends TaskEvent {
  final String id;
  

  PublishTask({required this.id,});
}

class AddTask extends TaskEvent {
  final String title;
  final String description;
  final bool completed;

  AddTask({required this.title, required this.description, required this.completed});
}

final class TaskLoad extends TaskEvent {
  
}

class DeleteTask extends TaskEvent {
  final String id;
  

  DeleteTask({required this.id,});
}


final class ToggleTaskCompletion extends TaskEvent {
  final String id;
  final bool completed;
  
   ToggleTaskCompletion(this.id, this.completed);
  

}
