import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetTaskEvent>(_getTaskEvent);
    on<UpdateTaskEvent>(_updateTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
  }

  FutureOr<void> _getTaskEvent(
      GetTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(TaskSuccessState(name: "Nguyen Minh Khoa"));
  }

  FutureOr<void> _updateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(TaskSuccessState(name: event.newName));
    emit(UpdateTaskSuccessState());
  }

  FutureOr<void> _deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskSuccessState(name: '...'));
    emit(DeleteTaskSuccessState());
  }
}
