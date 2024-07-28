part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}
class TaskAdded extends TaskState {}

final class TaskLoaded extends TaskState {
 final  List<dynamic> tasks;


 TaskLoaded(this.tasks);

}

final class TaskToggleCompleted extends TaskState {
 final  String id;
 final  bool completed;

 TaskToggleCompleted(this.id, this.completed);

}

class TaskUpdating extends TaskState {}

final class TaskError extends TaskState {
 final  String message;

 TaskError(this.message);
}

class TaskDeleted extends TaskState {}