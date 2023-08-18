import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/task_entity.dart';
import '../repository/task_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository = TaskRepository();

  TaskBloc() : super(TaskInitial()) {
    on<GetTaskEvent>(_getTaskEvent);
    on<AddTaskEvent>(_addTaskEvent);
    on<UpdateTaskEvent>(_updateTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
  }

  FutureOr<void> _getTaskEvent(
      GetTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    try {
      final tasks = await _repository.getTasks();
      final taskTitles = tasks.map((task) => task).toList();
      print("taskTitles: $taskTitles");
      emit(TaskSuccessState(dataTasks: taskTitles));
    } catch (e) {
      emit(TaskErrorState());
    }
  }

  Future<void> _addTaskEvent(
      AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    try {
      final newTaskEntity =
          TaskEntity(title: event.nameAdd); // Set id as needed
      await _repository.insertTask(newTaskEntity);

      final updatedTasks = await _repository.getTasks();
      final taskTitles = updatedTasks.map((task) => task).toList();
      emit(TaskSuccessState(dataTasks: taskTitles));
      emit(AddTaskSuccessState());
    } catch (e) {
      emit(TaskErrorState());
    }
  }

  FutureOr<void> _updateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    try {
      final tasks = await _repository.getTasks();
      if (tasks.isNotEmpty) {
        final firstTask = tasks.first;
        final updatedTaskEntity =
            TaskEntity(id: firstTask.id, title: event.newName);
        await _repository.updateTask(updatedTaskEntity);
      }

      final updatedTasks = await _repository.getTasks();
      final taskTitles = updatedTasks.map((task) => task).toList();
      emit(TaskSuccessState(dataTasks: taskTitles));
      emit(UpdateTaskSuccessState());
    } catch (e) {
      emit(TaskErrorState());
    }
  }

  FutureOr<void> _deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    try {
      final tasks = await _repository.getTasks();
      if (tasks.isNotEmpty) {
        await _repository.deleteTask(event.idDelete);
      }

      final updatedTasks = await _repository.getTasks();
      final taskTitles = updatedTasks.map((task) => task).toList();
      emit(TaskSuccessState(dataTasks: taskTitles));
      emit(DeleteTaskSuccessState());
    } catch (e) {
      emit(TaskErrorState());
    }
  }
}
