part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetTaskEvent extends TaskEvent {}

class UpdateTaskEvent extends TaskEvent {
  final String newName;

  UpdateTaskEvent({required this.newName});
}

class AddTaskEvent extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {}
