part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

abstract class TasksActionState extends TaskState {}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskSuccessState extends TaskState {
  final String name;

  TaskSuccessState({required this.name});
}

class TaskErrorState extends TaskState {}

class UpdateTaskSuccessState extends TasksActionState {}

class AddTaskSuccessState extends TasksActionState {}

class DeleteTaskSuccessState extends TasksActionState {}
