import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:saral/constants/constant.dart';

import 'package:saral/models/task_model.dart';
import 'package:http/http.dart' as http;


part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required this.dio,required this.client}) : super(TaskInitial()) {
    on<TaskLoad>(_onTaskLoad);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
  }

  final Dio dio;
  final GraphQLClient client;


  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final result = await client.mutate(MutationOptions(
        document: gql(QueryConstants.deletTaskMutation),
        variables: {
          'id': event.id,
        },
      ));

      if (result.hasException) {
        emit(TaskError(result.exception.toString()));
      } else {
        add(TaskLoad());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      final now = DateTime.now().toUtc();
  final formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now); // Format with milliseconds and 'Z' for UTC
      final result = await client.mutate(MutationOptions(
        document: gql(QueryConstants.addTaskMutation),
        variables: {
          'title': event.title,
          'description': event.description,
          'completed': event.completed,
          'publishedAt': formattedDate,
        },
      ));

      if (result.hasException) {
        print(result.exception);
        emit(TaskError(result.exception.toString()));
      } else {
        add(TaskLoad());
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskLoad(TaskLoad event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await dio.get
      
      (
        BasicApiConstants.BASE_URL,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${BasicApiConstants.API_KEY}',
          },
        )
      
      );
      print(tasks);
     List<Task> taskList = (tasks.data["data"] as List).map((e) => Task.fromMap(e)).toList();
      // print(postsList.last);
    print(taskList);
    emit(TaskLoaded(taskList));

      // emit(TaskLoaded(tasks));
    } catch (e) {
      print(e);
      emit(TaskError('Failed to fetch tasks'));
    }
  }

  


  Future<void> _onToggleTaskCompletion(ToggleTaskCompletion event,Emitter<TaskState> emit) async {
    emit(TaskLoading());
   
      
      

         const String updateTaskCompletedMutation = QueryConstants.updateCompletedMutationquery;

      try {
        final result = await client.mutate(MutationOptions(
          document: gql(updateTaskCompletedMutation),
          variables: {
            'id': event.id,
            'completed': event.completed,
          },
        ));
        // print(result);
      

      print('Mutation Result: ${result.data}');
      // emit(TaskLoaded(updatedTasks));
        // emit(TaskLoaded(updatedTasks));
        add(TaskLoad());
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    }
  }

